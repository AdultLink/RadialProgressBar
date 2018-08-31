// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "AdultLink/RadialProgressBar/SimpleRadialProgressBar_UI"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
		[PerRendererData] _AlphaTex ("External Alpha", 2D) = "white" {}
		_Radius("Radius", Range( 0 , 1)) = 0.3
		_Arcrange("Arc range", Range( 0 , 360)) = 360
		_Fillpercentage("Fill percentage", Range( 0 , 1)) = 0.25
		_Globalopacity("Global opacity", Range( 0 , 1)) = 1
		[HDR]_Barmincolor("Bar min color", Color) = (1,0,0,1)
		[HDR]_Barmaxcolor("Bar max color", Color) = (0,1,0.08965516,1)
		_Rotation("Rotation", Range( 0 , 360)) = 0
	}

	SubShader
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="True" }

		Cull Off
		Lighting Off
		ZWrite Off
		Blend One OneMinusSrcAlpha
		
		
		Pass
		{
		CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile _ PIXELSNAP_ON
			#pragma multi_compile _ ETC1_EXTERNAL_ALPHA
			#include "UnityCG.cginc"
			

			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				float2 texcoord  : TEXCOORD0;
				UNITY_VERTEX_OUTPUT_STEREO
				
			};
			
			uniform fixed4 _Color;
			uniform float _EnableExternalAlpha;
			uniform sampler2D _MainTex;
			uniform sampler2D _AlphaTex;
			uniform float _Rotation;
			uniform float _Fillpercentage;
			uniform float _Arcrange;
			uniform float _Radius;
			uniform float4 _Barmincolor;
			uniform float4 _Barmaxcolor;
			uniform float _Globalopacity;
			
			v2f vert( appdata_t IN  )
			{
				v2f OUT;
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
				
				
				IN.vertex.xyz +=  float3(0,0,0) ; 
				OUT.vertex = UnityObjectToClipPos(IN.vertex);
				OUT.texcoord = IN.texcoord;
				OUT.color = IN.color * _Color;
				#ifdef PIXELSNAP_ON
				OUT.vertex = UnityPixelSnap (OUT.vertex);
				#endif

				return OUT;
			}

			fixed4 SampleSpriteTexture (float2 uv)
			{
				fixed4 color = tex2D (_MainTex, uv);

#if ETC1_EXTERNAL_ALPHA
				// get the color from an external texture (usecase: Alpha support for ETC1 on android)
				fixed4 alpha = tex2D (_AlphaTex, uv);
				color.a = lerp (color.a, alpha.r, _EnableExternalAlpha);
#endif //ETC1_EXTERNAL_ALPHA

				return color;
			}
			
			fixed4 frag(v2f IN  ) : SV_Target
			{
				float2 uv1 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_11_0 = (float2( -1,-1 ) + (uv1 - float2( 0,0 )) * (float2( 1,1 ) - float2( -1,-1 )) / (float2( 1,1 ) - float2( 0,0 )));
				float cos251 = cos( radians( _Rotation ) );
				float sin251 = sin( radians( _Rotation ) );
				float2 rotator251 = mul( temp_output_11_0 - float2( 0,0 ) , float2x2( cos251 , -sin251 , sin251 , cos251 )) + float2( 0,0 );
				float2 break28 = (rotator251).xy;
				float Fillpercentage140 = _Fillpercentage;
				float ArcRange205 = (0.0 + (_Arcrange - 0.0) * (1.0 - 0.0) / (360.0 - 0.0));
				float MainbarFillPercentage145 = ceil( ( (0.0 + (atan2( break28.y , break28.x ) - -UNITY_PI) * (1.0 - 0.0) / (UNITY_PI - -UNITY_PI)) - (1.0 + (Fillpercentage140 - 0.0) * ((1.0 + (ArcRange205 - 0.0) * (0.0 - 1.0) / (1.0 - 0.0)) - 1.0) / (1.0 - 0.0)) ) );
				float BarRadius133 = _Radius;
				float Length135 = length( temp_output_11_0 );
				float MainbarFill150 = ( MainbarFillPercentage145 * floor( ( BarRadius133 + Length135 ) ) * ( 1.0 - floor( Length135 ) ) );
				float4 lerpResult6 = lerp( _Barmincolor , _Barmaxcolor , Fillpercentage140);
				float4 BarColor123 = lerpResult6;
				float4 break250 = ( MainbarFill150 * BarColor123 );
				float Opacity202 = _Globalopacity;
				float4 appendResult255 = (float4(break250.r , break250.g , break250.b , ( break250.a * Opacity202 )));
				
				fixed4 c = appendResult255;
				c.rgb *= c.a;
				return c;
			}
		ENDCG
		}
	}
	CustomEditor "AdultLink.SimpleRadialProgressBarEditor"
	
	
}
/*ASEBEGIN
Version=15500
438;92;1092;348;967.7916;276.1252;5.936939;True;False
Node;AmplifyShaderEditor.CommentaryNode;114;-1068.275,-511.0027;Float;False;3476.698;885.0037;Generate percentage masks;20;253;252;11;1;251;135;12;145;34;33;36;29;23;105;208;141;207;28;30;26;Generate percentage masks;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;253;-348.6919,-304.7794;Float;False;Property;_Rotation;Rotation;6;0;Create;True;0;0;False;0;0;0;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1009.143,-386.3943;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;11;-728.0178,-385.5548;Float;True;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-1,-1;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;166;2521.354,-1054.494;Float;False;787.2336;625.4528;Parameters;9;202;200;205;204;203;133;140;15;10;Parameters;0.6764706,1,0.7590263,1;0;0
Node;AmplifyShaderEditor.RadiansOpNode;252;-64.46992,-303.3305;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;251;92.80603,-385.5121;Float;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;203;2582.241,-654.9225;Float;False;Property;_Arcrange;Arc range;1;0;Create;True;0;0;False;0;360;360;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;204;2870.525,-650.0024;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;360;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;26;360.2321,-389.2923;Float;True;True;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;205;3054.404,-660.0614;Float;False;ArcRange;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;2582.99,-856.6338;Float;False;Property;_Fillpercentage;Fill percentage;2;0;Create;True;0;0;False;0;0.25;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;28;610.0744,-387.9627;Float;True;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.PiNode;30;720.6699,-24.83198;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;207;502.7415,166.418;Float;False;205;0;1;FLOAT;0
Node;AmplifyShaderEditor.ATan2OpNode;23;895.0297,-388.073;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;105;896.0353,-168.0731;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;208;718.5518,173.3417;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;140;2871.935,-857.8337;Float;False;Fillpercentage;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;141;724.7806,89.26335;Float;False;140;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;2583.377,-956.223;Float;False;Property;_Radius;Radius;0;0;Create;True;0;0;False;0;0.3;0.584;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;29;1290.431,-383.1414;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;12;-146.6821,-18.49937;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;36;939.4335,173.5196;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;107;984.7448,491.6664;Float;False;1425.286;534.8368;Mainbar Fill;9;150;20;147;17;19;16;14;134;136;Mainbar Fill;1,0.9726166,0.6029412,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;136;1032.217,679.0547;Float;False;135;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;33;1717.426,-380.1949;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;134;1034.675,547.3527;Float;False;133;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;135;-5.505921,-25.16647;Float;True;Length;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;133;2856.906,-954.995;Float;False;BarRadius;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;34;1926.389,-380.5506;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;16;1292.082,777.1596;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;1268.657,550.3856;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;112;1484.914,-1052.182;Float;False;920.9249;437.3615;Bar color;5;7;8;143;6;123;Bar color;1,0.7058823,0.7058823,1;0;0
Node;AmplifyShaderEditor.ColorNode;8;1536.364,-991.1611;Float;False;Property;_Barmincolor;Bar min color;4;1;[HDR];Create;True;0;0;False;0;1,0,0,1;1,0,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;147;1769.603,551.5345;Float;False;145;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;143;1772.419,-725.0977;Float;False;140;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;145;2059.49,-384.9758;Float;True;MainbarFillPercentage;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;7;1533.123,-819.3827;Float;False;Property;_Barmaxcolor;Bar max color;5;1;[HDR];Create;True;0;0;False;0;0,1,0.08965516,1;0.02897927,0.985294,0.3125737,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FloorOpNode;19;1517.984,549.8055;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;17;1518.896,777.9907;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;165;2525.632,-219.5178;Float;False;1539.136;601.1789;Final composition;8;254;199;255;250;201;39;124;156;Final composition;0.6470588,0.8539554,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;6;1996.323,-869.157;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;1998.227,738.2614;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;123;2152.373,-874.3439;Float;True;BarColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;150;2157.163,733.7111;Float;True;MainbarFill;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;156;2585.548,-136.3815;Float;True;150;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;124;2589.843,67.94649;Float;True;123;0;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;200;2585.528,-755.7354;Float;False;Property;_Globalopacity;Global opacity;3;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;2867.567,-37.12125;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;202;2889.345,-758.8372;Float;False;Opacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;250;3111.264,34.61466;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;201;3138.242,189.8047;Float;False;202;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;199;3375.673,140.0199;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;255;3633.447,28.98363;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;254;3805.914,29.32011;Float;False;True;2;Float;AdultLink.SimpleRadialProgressBarEditor;0;5;AdultLink/RadialProgressBar/SimpleRadialProgressBar_UI;0f8ba0101102bb14ebf021ddadce9b49;0;0;SubShader 0 Pass 0;2;True;3;1;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;True;2;False;-1;False;False;True;2;False;-1;False;False;True;5;Queue=Transparent;IgnoreProjector=True;RenderType=Transparent;PreviewType=Plane;CanUseSpriteAtlas=True;False;0;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;11;0;1;0
WireConnection;252;0;253;0
WireConnection;251;0;11;0
WireConnection;251;2;252;0
WireConnection;204;0;203;0
WireConnection;26;0;251;0
WireConnection;205;0;204;0
WireConnection;28;0;26;0
WireConnection;23;0;28;1
WireConnection;23;1;28;0
WireConnection;105;0;30;0
WireConnection;208;0;207;0
WireConnection;140;0;10;0
WireConnection;29;0;23;0
WireConnection;29;1;105;0
WireConnection;29;2;30;0
WireConnection;12;0;11;0
WireConnection;36;0;141;0
WireConnection;36;4;208;0
WireConnection;33;0;29;0
WireConnection;33;1;36;0
WireConnection;135;0;12;0
WireConnection;133;0;15;0
WireConnection;34;0;33;0
WireConnection;16;0;136;0
WireConnection;14;0;134;0
WireConnection;14;1;136;0
WireConnection;145;0;34;0
WireConnection;19;0;14;0
WireConnection;17;0;16;0
WireConnection;6;0;8;0
WireConnection;6;1;7;0
WireConnection;6;2;143;0
WireConnection;20;0;147;0
WireConnection;20;1;19;0
WireConnection;20;2;17;0
WireConnection;123;0;6;0
WireConnection;150;0;20;0
WireConnection;39;0;156;0
WireConnection;39;1;124;0
WireConnection;202;0;200;0
WireConnection;250;0;39;0
WireConnection;199;0;250;3
WireConnection;199;1;201;0
WireConnection;255;0;250;0
WireConnection;255;1;250;1
WireConnection;255;2;250;2
WireConnection;255;3;199;0
WireConnection;254;0;255;0
ASEEND*/
//CHKSM=BF8E2924FBD09862D542BC1EB311290C31DFDD9E