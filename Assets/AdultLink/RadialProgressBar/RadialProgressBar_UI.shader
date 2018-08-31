// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "AdultLink/RadialProgressBar/RadialProgressBar_UI"
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
		[HDR]_Barmincolor("Bar min color", Color) = (1,0,0,1)
		[HDR]_Barmaxcolor("Bar max color", Color) = (0,1,0.08965516,1)
		[HDR]_Barsecondarymincolor("Bar secondary min color", Color) = (1,0,0,1)
		[HDR]_Barsecondarymaxcolor("Bar secondary max color", Color) = (0,1,0.08965516,1)
		[HDR]_Bordermincolor("Border min color", Color) = (1,0,0,1)
		[HDR]_Bordermaxcolor("Border max color", Color) = (0,1,0.08965516,1)
		_Mainborderradialwidth("Main border radial width", Range( 0 , 0.2)) = 0
		_Mainbordertangentwidth("Main border tangent width", Range( 0 , 1)) = 0
		_Backgroundbordertangentwidth("Background border tangent width", Range( 0 , 1)) = 0
		_Backgroundborderradialwidth("Background border radial width", Range( 0 , 0.2)) = 0
		[HDR]_Backgroundbordercolor("Background border color", Color) = (0.2132353,0.6418865,1,1)
		[HDR]_Backgroundfillcolor("Background fill color", Color) = (0.2132353,0.6418865,1,1)
		[NoScaleOffset]_Maintex("Main tex", 2D) = "white" {}
		_Maintexscrollspeed("Main tex scroll speed", Vector) = (0,0,0,0)
		_Maintextiling("Main tex tiling", Vector) = (0,0,0,0)
		_Maintexoffset("Main tex offset", Vector) = (0,0,0,0)
		[NoScaleOffset]_Secondarytex("Secondary tex", 2D) = "black" {}
		_Secondarytexscrollspeed("Secondary tex scroll speed", Vector) = (0,0,0,0)
		_Secondarytextiling("Secondary tex tiling", Vector) = (0,0,0,0)
		_Secondarytexoffset("Secondary tex offset", Vector) = (0,0,0,0)
		[NoScaleOffset]_Noisetex("Noise tex", 2D) = "white" {}
		[Toggle]_Invertnoisetex("Invertnoisetex", Float) = 0
		_Noisetexspeed("Noise tex speed", Vector) = (0,0,0,0)
		_Noisetextiling("Noise tex tiling", Vector) = (0,0,0,0)
		_Noisetexoffset("Noise tex offset", Vector) = (0,0,0,0)
		_Noiseintensity("Noise intensity", Float) = 5
		_Maintexrotationspeed("Main tex rotation speed", Float) = 1
		_Secondarytexrotationspeed("Secondary tex rotation speed", Float) = 1
		[KeywordEnum(Scroll,Rotate,None)] _Mainscrollrotate("Main scroll rotate", Float) = 0
		[KeywordEnum(Scroll,Rotate,None)] _Secondaryscrollrotate("Secondary scroll rotate", Float) = 0
		_Globalopacity("Global opacity", Range( 0 , 1)) = 1
		_Backgroundborderopacity("Background border opacity", Range( 0 , 1)) = 1
		_Backgroundopacity("Background opacity", Range( 0 , 1)) = 1
		_Secondarytexopacity("Secondary tex opacity", Range( 0 , 1)) = 1
		_Maintexopacity("Main tex opacity", Range( 0 , 1)) = 1
		_Mainbarborderopacity("Main bar border opacity", Range( 0 , 1)) = 1
		_Rotation("Rotation", Range( 0 , 360)) = 0
		[Toggle]_Invertsecondarytex("Invert secondary tex", Float) = 0
		[Toggle]_Invertmaintex("Invert main tex", Float) = 0
		_Noisetexcontrast("Noise tex contrast", Float) = 1
		_Secondarytexcontrast("Secondary tex contrast", Float) = 1
		_Maintexcontrast("Main tex contrast", Float) = 1
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
			#include "UnityShaderVariables.cginc"
			#pragma shader_feature _SECONDARYSCROLLROTATE_SCROLL _SECONDARYSCROLLROTATE_ROTATE _SECONDARYSCROLLROTATE_NONE
			#pragma shader_feature _MAINSCROLLROTATE_SCROLL _MAINSCROLLROTATE_ROTATE _MAINSCROLLROTATE_NONE


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
			uniform float _Secondarytexcontrast;
			uniform float _Invertsecondarytex;
			uniform sampler2D _Secondarytex;
			uniform float2 _Secondarytexscrollspeed;
			uniform float2 _Secondarytextiling;
			uniform float2 _Secondarytexoffset;
			uniform float _Secondarytexrotationspeed;
			uniform float _Noisetexcontrast;
			uniform float _Invertnoisetex;
			uniform sampler2D _Noisetex;
			uniform float2 _Noisetexspeed;
			uniform float2 _Noisetextiling;
			uniform float2 _Noisetexoffset;
			uniform float _Noiseintensity;
			uniform float _Mainborderradialwidth;
			uniform float _Backgroundborderradialwidth;
			uniform float _Rotation;
			uniform float _Mainbordertangentwidth;
			uniform float _Fillpercentage;
			uniform float _Arcrange;
			uniform float _Backgroundbordertangentwidth;
			uniform float _Radius;
			uniform float4 _Barsecondarymincolor;
			uniform float4 _Barsecondarymaxcolor;
			uniform float _Secondarytexopacity;
			uniform float4 _Bordermincolor;
			uniform float4 _Bordermaxcolor;
			uniform float _Mainbarborderopacity;
			uniform float _Maintexcontrast;
			uniform float _Invertmaintex;
			uniform sampler2D _Maintex;
			uniform float2 _Maintexscrollspeed;
			uniform float2 _Maintextiling;
			uniform float2 _Maintexoffset;
			uniform float _Maintexrotationspeed;
			uniform float4 _Barmincolor;
			uniform float4 _Barmaxcolor;
			uniform float _Maintexopacity;
			uniform float4 _Backgroundbordercolor;
			uniform float _Backgroundborderopacity;
			uniform float4 _Backgroundfillcolor;
			uniform float _Backgroundopacity;
			uniform float _Globalopacity;
			float4 CalculateContrast( float contrastValue, float4 colorTarget )
			{
				float t = 0.5 * ( 1.0 - contrastValue );
				return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
			}
			
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
				float2 temp_output_332_0 = (float2( 0,0 ) + (_Secondarytexoffset - float2( 0,0 )) * (float2( 1,1 ) - float2( 0,0 )) / (float2( 360,360 ) - float2( 0,0 )));
				float2 uv341 = IN.texcoord.xy * _Secondarytextiling + temp_output_332_0;
				float2 panner343 = ( _Time.y * (float2( 0,0 ) + (_Secondarytexscrollspeed - float2( 0,0 )) * (float2( 0.01,0.01 ) - float2( 0,0 )) / (float2( 1,1 ) - float2( 0,0 ))) + uv341);
				float2 uv339 = IN.texcoord.xy * _Secondarytextiling + temp_output_332_0;
				float mulTime340 = _Time.y * _Secondarytexrotationspeed;
				float cos344 = cos( mulTime340 );
				float sin344 = sin( mulTime340 );
				float2 rotator344 = mul( uv339 - ( _Secondarytextiling * float2( 0.5,0.5 ) ) , float2x2( cos344 , -sin344 , sin344 , cos344 )) + ( _Secondarytextiling * float2( 0.5,0.5 ) );
				#if defined(_SECONDARYSCROLLROTATE_SCROLL)
				float2 staticSwitch345 = panner343;
				#elif defined(_SECONDARYSCROLLROTATE_ROTATE)
				float2 staticSwitch345 = rotator344;
				#elif defined(_SECONDARYSCROLLROTATE_NONE)
				float2 staticSwitch345 = uv341;
				#else
				float2 staticSwitch345 = panner343;
				#endif
				float4 tex2DNode89 = tex2D( _Secondarytex, staticSwitch345 );
				float4 appendResult415 = (float4(( 1.0 - tex2DNode89.r ) , ( 1.0 - tex2DNode89.g ) , ( 1.0 - tex2DNode89.b ) , tex2DNode89.a));
				float4 Secondarytexture126 = CalculateContrast(_Secondarytexcontrast,lerp(tex2DNode89,appendResult415,_Invertsecondarytex));
				float2 uv94 = IN.texcoord.xy * _Noisetextiling + _Noisetexoffset;
				float2 panner96 = ( _Time.y * (float2( 0,0 ) + (_Noisetexspeed - float2( 0,0 )) * (float2( 0.01,0.01 ) - float2( 0,0 )) / (float2( 1,1 ) - float2( 0,0 ))) + uv94);
				float Noiseintensity167 = _Noiseintensity;
				float4 temp_output_98_0 = ( tex2D( _Noisetex, panner96 ) * Noiseintensity167 );
				float4 Noisetexture127 = CalculateContrast(_Noisetexcontrast,lerp(temp_output_98_0,( 1.0 - temp_output_98_0 ),_Invertnoisetex));
				float2 uv1 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float MainbarBorderwidth138 = _Mainborderradialwidth;
				float BackgroundBorderWidth183 = _Backgroundborderradialwidth;
				float2 temp_output_74_0 = ( float2( 1,1 ) + MainbarBorderwidth138 + BackgroundBorderWidth183 );
				float2 temp_output_11_0 = (-temp_output_74_0 + (uv1 - float2( 0,0 )) * (temp_output_74_0 - -temp_output_74_0) / (float2( 1,1 ) - float2( 0,0 )));
				float cos403 = cos( radians( _Rotation ) );
				float sin403 = sin( radians( _Rotation ) );
				float2 rotator403 = mul( temp_output_11_0 - float2( 0,0 ) , float2x2( cos403 , -sin403 , sin403 , cos403 )) + float2( 0,0 );
				float2 break28 = (rotator403).xy;
				float temp_output_29_0 = (0.0 + (atan2( break28.y , break28.x ) - -UNITY_PI) * (1.0 - 0.0) / (UNITY_PI - -UNITY_PI));
				float Borderwidth2157 = (0.0 + (_Mainbordertangentwidth - 0.0) * (0.05 - 0.0) / (1.0 - 0.0));
				float Fillpercentage140 = _Fillpercentage;
				float ArcRange205 = (0.0 + (_Arcrange - 0.0) * (1.0 - 0.0) / (360.0 - 0.0));
				float BorderWidth3252 = (0.0 + (_Backgroundbordertangentwidth - 0.0) * (0.05 - 0.0) / (1.0 - 0.0));
				float MainbarFillPercentage145 = ceil( ( temp_output_29_0 - ( Borderwidth2157 + (1.0 + (Fillpercentage140 - 0.0) * ((1.0 + (ArcRange205 - 0.0) * (0.0 - 1.0) / (1.0 - 0.0)) - 1.0) / (1.0 - 0.0)) + BorderWidth3252 ) ) );
				float BarRadius133 = _Radius;
				float Length135 = length( temp_output_11_0 );
				float MainbarFill150 = ( MainbarFillPercentage145 * floor( ( BarRadius133 + Length135 ) ) * ( 1.0 - floor( Length135 ) ) );
				float4 lerpResult236 = lerp( _Barsecondarymincolor , _Barsecondarymaxcolor , Fillpercentage140);
				float4 BarSecondaryColor237 = lerpResult236;
				float4 break383 = ( Secondarytexture126 * Noisetexture127 * MainbarFill150 * BarSecondaryColor237 );
				float4 appendResult385 = (float4(break383.r , break383.g , break383.b , ( break383.a * _Secondarytexopacity )));
				float4 lerpResult73 = lerp( _Bordermincolor , _Bordermaxcolor , Fillpercentage140);
				float4 Bordercolor121 = lerpResult73;
				float MainbarBorderPercentage146 = ceil( ( temp_output_29_0 - (1.0 + (( ( Fillpercentage140 * ArcRange205 ) - BorderWidth3252 ) - 0.0) * (0.0 - 1.0) / (1.0 - 0.0)) ) );
				float temp_output_47_0 = floor( ( BarRadius133 + MainbarBorderwidth138 + Length135 ) );
				float temp_output_50_0 = ( 1.0 - floor( ( Length135 + -MainbarBorderwidth138 ) ) );
				float Biggercircle151 = ( MainbarBorderPercentage146 * temp_output_47_0 * temp_output_50_0 );
				float MainbarBorder161 = ( Biggercircle151 - MainbarFill150 );
				float4 break386 = ( Bordercolor121 * MainbarBorder161 );
				float4 appendResult389 = (float4(break386.r , break386.g , break386.b , ( break386.a * _Mainbarborderopacity )));
				float2 temp_output_357_0 = (float2( 0,0 ) + (_Maintexoffset - float2( 0,0 )) * (float2( 1,1 ) - float2( 0,0 )) / (float2( 360,360 ) - float2( 0,0 )));
				float2 uv349 = IN.texcoord.xy * _Maintextiling + temp_output_357_0;
				float2 panner352 = ( _Time.y * (float2( 0,0 ) + (_Maintexscrollspeed - float2( 0,0 )) * (float2( 0.01,0.01 ) - float2( 0,0 )) / (float2( 1,1 ) - float2( 0,0 ))) + uv349);
				float2 uv348 = IN.texcoord.xy * _Maintextiling + temp_output_357_0;
				float mulTime347 = _Time.y * _Maintexrotationspeed;
				float cos351 = cos( mulTime347 );
				float sin351 = sin( mulTime347 );
				float2 rotator351 = mul( uv348 - ( _Maintextiling * float2( 0.5,0.5 ) ) , float2x2( cos351 , -sin351 , sin351 , cos351 )) + ( _Maintextiling * float2( 0.5,0.5 ) );
				#if defined(_MAINSCROLLROTATE_SCROLL)
				float2 staticSwitch353 = panner352;
				#elif defined(_MAINSCROLLROTATE_ROTATE)
				float2 staticSwitch353 = rotator351;
				#elif defined(_MAINSCROLLROTATE_NONE)
				float2 staticSwitch353 = uv349;
				#else
				float2 staticSwitch353 = panner352;
				#endif
				float4 tex2DNode38 = tex2D( _Maintex, staticSwitch353 );
				float4 appendResult408 = (float4(( 1.0 - tex2DNode38.r ) , ( 1.0 - tex2DNode38.g ) , ( 1.0 - tex2DNode38.b ) , tex2DNode38.a));
				float4 Maintexture131 = CalculateContrast(_Maintexcontrast,lerp(tex2DNode38,appendResult408,_Invertmaintex));
				float4 lerpResult6 = lerp( _Barmincolor , _Barmaxcolor , Fillpercentage140);
				float4 BarColor123 = lerpResult6;
				float4 break390 = ( MainbarFill150 * Maintexture131 * BarColor123 );
				float4 appendResult393 = (float4(break390.r , break390.g , break390.b , ( break390.a * _Maintexopacity )));
				float temp_output_258_0 = (1.0 + (ArcRange205 - 0.0) * (0.0 - 1.0) / (1.0 - 0.0));
				float BackgroundBorderPercentage257 = ceil( ( temp_output_29_0 - temp_output_258_0 ) );
				float temp_output_186_0 = ( MainbarBorderwidth138 + BackgroundBorderWidth183 );
				float Background181 = ( BackgroundBorderPercentage257 * floor( ( BarRadius133 + temp_output_186_0 + Length135 ) ) * ( 1.0 - floor( ( Length135 + -temp_output_186_0 ) ) ) );
				float BackgroundFillPercentage211 = ceil( ( temp_output_29_0 - ( BorderWidth3252 + temp_output_258_0 ) ) );
				float BackgroundFillFull262 = ( BackgroundFillPercentage211 * floor( ( BarRadius133 + MainbarBorderwidth138 + Length135 ) ) * ( 1.0 - floor( ( Length135 + -MainbarBorderwidth138 ) ) ) );
				float clampResult217 = clamp( ( Background181 - BackgroundFillFull262 ) , 0.0 , 1.0 );
				float BackgroundBorder191 = clampResult217;
				float4 BGColor194 = _Backgroundbordercolor;
				float4 break394 = ( BackgroundBorder191 * BGColor194 );
				float4 appendResult397 = (float4(break394.r , break394.g , break394.b , ( break394.a * _Backgroundborderopacity )));
				float BackgroundFillEmpty223 = ( BackgroundFillFull262 - Biggercircle151 );
				float4 BackgroundFillColor229 = _Backgroundfillcolor;
				float4 break398 = ( BackgroundFillEmpty223 * BackgroundFillColor229 );
				float4 appendResult401 = (float4(break398.r , break398.g , break398.b , ( break398.a * _Backgroundopacity )));
				float4 break372 = ( appendResult385 + appendResult389 + appendResult393 + appendResult397 + appendResult401 );
				float Opacity377 = _Globalopacity;
				float4 appendResult375 = (float4(break372.x , break372.y , break372.z , ( break372.w * Opacity377 )));
				
				fixed4 c = appendResult375;
				c.rgb *= c.a;
				return c;
			}
		ENDCG
		}
	}
	CustomEditor "AdultLink.RadialProgressBarEditor"
	
	
}
/*ASEBEGIN
Version=15500
438;92;1092;348;-2332.861;315.7816;4.528319;True;False
Node;AmplifyShaderEditor.RangedFloatNode;182;4172.921,619.031;Float;False;Property;_Backgroundborderradialwidth;Background border radial width;12;0;Create;True;0;0;False;0;0;0.039;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;4159.64,-241.3051;Float;False;Property;_Mainborderradialwidth;Main border radial width;9;0;Create;True;0;0;False;0;0;0.031;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;183;4466.886,620.6659;Float;False;BackgroundBorderWidth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;138;4436.015,-241.4851;Float;False;MainbarBorderwidth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;190;-4313.831,448.7917;Float;False;183;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;159;-4309.963,365.6686;Float;False;138;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;75;-4290.765,231.4662;Float;False;Constant;_Vector0;Vector 0;11;0;Create;True;0;0;False;0;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;74;-4056.31,288.772;Float;False;3;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;402;-3063.016,374.5025;Float;False;Property;_Rotation;Rotation;39;0;Create;True;0;0;False;0;0;0;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;104;-3929.621,224.6523;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-4020.306,-352.464;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;11;-3512.511,185.5932;Float;True;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-1,-1;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RadiansOpNode;404;-2778.794,375.9514;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;403;-2617.584,268.1991;Float;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;203;4160.519,1236.924;Float;False;Property;_Arcrange;Arc range;1;0;Create;True;0;0;False;0;360;360;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;26;-2348.671,323.6691;Float;True;True;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PiNode;30;-1946.094,647.7456;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;109;-2320.172,-2107.718;Float;False;3575.291;931.7201;Secondary texture;24;126;418;417;416;415;414;413;412;89;345;343;344;340;339;337;361;341;342;119;336;332;334;85;120;Secondary texture;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;108;-2344.118,-3124.635;Float;False;3396.547;829.8194;Main texture;24;131;411;410;409;408;407;406;405;38;353;351;352;350;355;349;360;348;347;346;358;45;357;115;116;Main texture;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;10;4155.891,-45.327;Float;False;Property;_Fillpercentage;Fill percentage;2;0;Create;True;0;0;False;0;0.25;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;251;4149.741,271.6759;Float;False;Property;_Backgroundbordertangentwidth;Background border tangent width;11;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;204;4448.803,1241.844;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;360;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;28;-2098.829,324.9987;Float;True;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.NegateNode;105;-1739.124,685.3541;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;259;-1138.713,135.584;Float;False;205;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;140;4444.837,-46.52695;Float;False;Fillpercentage;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;116;-2286.432,-2763.068;Float;False;Property;_Maintexoffset;Main tex offset;18;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;120;-2247.264,-1735.298;Float;False;Property;_Secondarytexoffset;Secondary tex offset;22;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;213;-1467.342,680.778;Float;False;205;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;296;4469.235,289.0914;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.05;False;1;FLOAT;0
Node;AmplifyShaderEditor.ATan2OpNode;23;-1813.874,324.8884;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;142;-1489.249,599.0247;Float;False;140;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;170;-2619.162,3055.632;Float;False;138;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;205;4632.683,1231.785;Float;False;ArcRange;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;4153.716,61.35442;Float;False;Property;_Mainbordertangentwidth;Main border tangent width;10;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;207;-2007.468,120.3304;Float;False;205;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;184;-2623.425,3157.401;Float;False;183;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;334;-1605.186,-1788.907;Float;False;Property;_Secondarytexrotationspeed;Secondary tex rotation speed;30;0;Create;True;0;0;False;0;1;-0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;332;-1962.248,-1730.703;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;360,360;False;3;FLOAT2;0,0;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;119;-2015.991,-2019.301;Float;False;Property;_Secondarytextiling;Secondary tex tiling;21;0;Create;True;0;0;False;0;0,0;0.2,0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;336;-1971.009,-1873.035;Float;False;Constant;_Anchorbase2;Anchor base2;47;0;Create;True;0;0;False;0;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;346;-1659.131,-2801.413;Float;False;Property;_Maintexrotationspeed;Main tex rotation speed;29;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;357;-2052.041,-2759.7;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;360,360;False;3;FLOAT2;0,0;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;115;-2055.647,-3046.702;Float;False;Property;_Maintextiling;Main tex tiling;17;0;Create;True;0;0;False;0;0,0;0.5,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;45;-1884.73,-2537.008;Float;False;Property;_Maintexscrollspeed;Main tex scroll speed;16;0;Create;True;0;0;False;0;0,0;1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;85;-1877.88,-1540.555;Float;False;Property;_Secondarytexscrollspeed;Secondary tex scroll speed;20;0;Create;True;0;0;False;0;0,0;-0.5,-0.15;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;358;-2060.801,-2902.032;Float;False;Constant;_Anchorbase;Anchor base;47;0;Create;True;0;0;False;0;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;141;-1785.429,43.17583;Float;False;140;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;265;-963.3506,-101.0643;Float;False;252;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;303;-1483.998,768.8998;Float;False;252;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;295;4447.873,73.40568;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.05;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;29;-1543.135,359.6689;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;258;-958.3196,142.1667;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;214;-1227.301,609.2108;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;208;-1791.658,127.2541;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;186;-2328.033,3118.946;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;252;4646.44,290.4834;Float;False;BorderWidth3;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;12;-3171.194,545.6484;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;274;-2495.224,3802.979;Float;False;138;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;110;-2015.344,-1105.234;Float;False;2399.797;549.4152;Noise texture;15;127;420;419;92;98;247;246;168;96;94;95;362;117;93;118;Noise texture;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;339;-1509.71,-2008.733;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;349;-1623.271,-2685.303;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;337;-1517.905,-1381.425;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;117;-1980.337,-1037.508;Float;False;Property;_Noisetextiling;Noise tex tiling;26;0;Create;True;0;0;False;0;0,0;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;355;-1602.672,-2366.036;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;340;-1311.703,-1789.929;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;360;-1600.865,-2555.091;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;0,0;False;4;FLOAT2;0.01,0.01;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;341;-1552.857,-1682.755;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;342;-1509.34,-1891.972;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;350;-1578.398,-2920.969;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;361;-1518.296,-1558.35;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;0,0;False;4;FLOAT2;0.01,0.01;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;348;-1578.768,-3037.731;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;347;-1396.1,-2806.499;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;158;-1549.128,47.98973;Float;False;157;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;157;4624.759,72.02412;Float;False;Borderwidth2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;289;-1147.404,100.0991;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;304;-1150.411,467.7894;Float;False;252;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;118;-1984.956,-916.6685;Float;False;Property;_Noisetexoffset;Noise tex offset;27;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;93;-1957.809,-763.3;Float;False;Property;_Noisetexspeed;Noise tex speed;25;0;Create;True;0;0;False;0;0,0;-0.5,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.NegateNode;277;-2194.759,3981.393;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;135;-2994.661,537.0406;Float;True;Length;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;278;-2196.334,3904.757;Float;False;135;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;273;-748.0826,-92.72653;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;4156.279,-144.9161;Float;False;Property;_Radius;Radius;0;0;Create;True;0;0;False;0;0.3;0.256;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;171;-2138.211,3144.654;Float;False;135;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;302;-1070.292,752.7352;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;36;-1570.776,127.432;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;290;-1264.2,-143.6177;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;139;-2509.071,1398.734;Float;False;138;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;172;-2136.635,3221.29;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;280;-2464.102,3714.743;Float;False;133;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;103;-2203.931,1583.437;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;279;-2011.112,3958.256;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;351;-1189.17,-2924.878;Float;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;352;-1222.406,-2609.156;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;65;-842.91,637.4735;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;344;-1120.111,-1895.88;Float;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;343;-1153.346,-1580.159;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;209;-605.8688,-138.4702;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;173;-1952.988,3198.153;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;362;-1675.617,-863.2327;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;0,0;False;4;FLOAT2;0.01,0.01;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;94;-1709.039,-1001.192;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;95;-1671.085,-687.0905;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;137;-2227.285,1463.243;Float;False;135;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;255;-605.4991,94.28665;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;218;-795.887,438.9902;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;292;-1245.835,531.8734;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;174;-2405.979,2954.64;Float;False;133;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;133;4429.807,-143.6881;Float;False;BarRadius;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;-2473.275,1316.786;Float;False;133;0;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;210;-397.3276,-138.7356;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;51;-2020.285,1560.299;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;175;-1832.002,3199.905;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;281;-1964.888,3719.396;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;176;-1906.764,2959.293;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;96;-1355.665,-902.4893;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;134;-2470.613,1987.59;Float;False;133;0;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;282;-1890.126,3960.008;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;256;-396.9577,94.02127;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;33;-603.7076,337.7349;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;353;-896.7273,-2741.762;Float;False;Property;_Mainscrollrotate;Main scroll rotate;31;0;Create;True;0;0;False;0;0;0;0;True;;KeywordEnum;3;Scroll;Rotate;None;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;345;-852.3184,-1721.267;Float;False;Property;_Secondaryscrollrotate;Secondary scroll rotate;32;0;Create;True;0;0;False;0;0;0;1;True;;KeywordEnum;3;Scroll;Rotate;None;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;136;-2473.071,2119.291;Float;False;135;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;4169.984,499.3177;Float;False;Property;_Noiseintensity;Noise intensity;28;0;Create;True;0;0;False;0;5;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;66;-606.8147,573.4583;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;167;4365.541,499.7834;Float;False;Noiseintensity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;168;-1086.591,-750.968;Float;False;167;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;38;-554.5612,-2902.181;Float;True;Property;_Maintex;Main tex;15;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;89;-547.5554,-1742.818;Float;True;Property;_Secondarytex;Secondary tex;19;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FloorOpNode;16;-2213.207,2217.397;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;283;-1697.459,3972.193;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;179;-1639.334,3212.09;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;257;-259.8394,88.93338;Float;True;BackgroundBorderPercentage;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-2236.631,1990.623;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;49;-1899.3,1562.051;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;284;-1713.612,3718.816;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;261;-1725.569,2854.55;Float;False;257;0;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;177;-1655.487,2958.713;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;212;-1791.268,3616.776;Float;False;211;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;46;-1974.062,1321.438;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;211;-256.1796,-143.8235;Float;True;BackgroundFillPercentage;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;67;-393.7538,573.2755;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;34;-394.7443,337.3792;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;92;-1159.307,-947.4838;Float;True;Property;_Noisetex;Noise tex;23;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;407;-127.0702,-2921.165;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;-842.3475,-945.6967;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;414;-108.7208,-1632.661;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;413;-111.4469,-1698.178;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;405;-125.7072,-2789.925;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;406;-128.4333,-2855.441;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;145;-261.643,332.954;Float;True;MainbarFillPercentage;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;19;-1987.305,1990.043;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;412;-110.0839,-1763.901;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;260;-1384.749,3777.411;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;147;-1735.686,1991.772;Float;False;145;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;180;-1280.736,3012.119;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;50;-1706.632,1574.236;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;17;-1986.393,2218.228;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;149;-1518.75,1296.566;Float;False;146;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;146;-261.1469,568.8488;Float;True;MainbarBorderPercentage;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;47;-1722.785,1320.858;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;181;-1117.1,2994.273;Float;True;Background;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;-1241.511,1401.763;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;408;118.061,-2697.098;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;415;135.0473,-1539.835;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.OneMinusNode;246;-623.6175,-876.7789;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-1507.063,2178.498;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;262;-1230.803,3754.746;Float;True;BackgroundFillFull;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;233;5118.678,805.0606;Float;False;Property;_Barsecondarymincolor;Bar secondary min color;5;1;[HDR];Create;True;0;0;False;0;1,0,0,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;72;5141.84,-64.39629;Float;False;Property;_Bordermaxcolor;Border max color;8;1;[HDR];Create;True;0;0;False;0;0,1,0.08965516,1;0.01113755,0.7573529,0.2324282,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;143;5377.892,552.5139;Float;False;140;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;144;5411.979,24.92087;Float;False;140;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;240;-414.3459,3805.728;Float;False;151;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;409;310.9636,-3078.308;Float;False;Property;_Invertmaintex;Invert main tex;41;0;Create;True;0;0;False;0;0;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;410;330.3378,-2973.82;Float;False;Property;_Maintexcontrast;Main tex contrast;44;0;Create;True;0;0;False;0;1;0.8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;150;-1348.128,2173.948;Float;True;MainbarFill;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;235;5117.557,974.7197;Float;False;Property;_Barsecondarymaxcolor;Bar secondary max color;6;1;[HDR];Create;True;0;0;False;0;0,1,0.08965516,1;0,0,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;151;-1077.876,1395.799;Float;True;Biggercircle;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;8;5141.837,286.4486;Float;False;Property;_Barmincolor;Bar min color;3;1;[HDR];Create;True;0;0;False;0;1,0,0,1;0.02745098,0.9843138,0.3137254,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;417;327.9498,-1921.044;Float;False;Property;_Invertsecondarytex;Invert secondary tex;40;0;Create;True;0;0;False;0;0;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ToggleSwitchNode;247;-445.5462,-953.8237;Float;False;Property;_Invertnoisetex;Invertnoisetex;24;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;189;-417.7115,3279.102;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;419;-412.6865,-835.8079;Float;False;Property;_Noisetexcontrast;Noise tex contrast;42;0;Create;True;0;0;False;0;1;0.8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;234;5386.121,1058.323;Float;False;140;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;71;5149.703,-241.8233;Float;False;Property;_Bordermincolor;Border min color;7;1;[HDR];Create;True;0;0;False;0;1,0,0,1;0.01176471,0.7568628,0.2313725,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;416;347.3239,-1794.159;Float;False;Property;_Secondarytexcontrast;Secondary tex contrast;43;0;Create;True;0;0;False;0;1;0.8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;7;5138.596,458.229;Float;False;Property;_Barmaxcolor;Bar max color;4;1;[HDR];Create;True;0;0;False;0;0,1,0.08965516,1;0.02897927,0.985294,0.3125734,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleContrastOpNode;420;-187.3976,-942.1079;Float;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;418;623.7393,-1909.469;Float;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;411;551.6266,-3058.118;Float;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;193;4170.672,727.4504;Float;False;Property;_Backgroundbordercolor;Background border color;13;1;[HDR];Create;True;0;0;False;0;0.2132353,0.6418865,1,1;0.2195068,0.5362239,0.8529412,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;217;-203.8913,3286.892;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;236;5618.143,914.2628;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;285;-194.1326,3662.843;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;73;5643.618,-144.2223;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;165;1322.628,-329.5287;Float;False;2546.855;1710.77;Final composition;24;57;129;241;162;130;122;156;124;128;154;39;91;382;383;387;391;390;386;392;388;384;385;393;389;Final composition;0.6470588,0.8539554,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;6;5601.794,408.4546;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;230;4169.206,939.5326;Float;False;Property;_Backgroundfillcolor;Background fill color;14;1;[HDR];Create;True;0;0;False;0;0.2132353,0.6418865,1,1;0.05828281,0.5259269,0.7205882,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;160;-568.2471,1782.769;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;127;46.9848,-947.2374;Float;True;Noisetexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;131;778.2045,-3057.436;Float;True;Maintexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;126;882.5115,-1920.546;Float;True;Secondarytexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;121;5798.399,-143.9892;Float;True;Bordercolor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;197;1406.485,848.1989;Float;False;194;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;228;1386.801,1062.747;Float;False;223;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;128;1401.821,-181.2427;Float;False;127;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;124;1400.943,544.5403;Float;False;123;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;237;5774.193,909.0757;Float;True;BarSecondaryColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;223;-52.65546,3657.94;Float;True;BackgroundFillEmpty;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;229;4420.258,937.9106;Float;False;BackgroundFillColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;191;-53.09107,3282.352;Float;True;BackgroundBorder;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;196;1409.973,760.8313;Float;False;191;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;161;-221.9629,1766.11;Float;True;MainbarBorder;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;162;1395.319,207.747;Float;False;161;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;122;1395.488,115.942;Float;False;121;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;241;1376.175,-23.33563;Float;False;237;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;194;4428.448,731.2079;Float;False;BGColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;231;1386.649,1146.475;Float;False;229;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;154;1401.373,-100.1017;Float;False;150;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;123;5757.844,403.2677;Float;True;BarColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;156;1403.586,372.8387;Float;False;150;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;129;1400.486,-263.7046;Float;False;126;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;130;1402.119,455.3549;Float;False;131;0;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;1724.877,-164.7096;Float;True;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;195;1737.255,726.665;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;1732.843,425.8007;Float;True;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;221;1726.593,1063.537;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;1732.332,121.023;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;390;1959.458,380.6761;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;387;1946.853,254.6094;Float;False;Property;_Mainbarborderopacity;Main bar border opacity;38;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;391;1941.019,532.674;Float;False;Property;_Maintexopacity;Main tex opacity;37;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;394;1987.766,729.6344;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;399;1985.369,1215.165;Float;False;Property;_Backgroundopacity;Background opacity;35;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;383;1935.725,-261.752;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;386;1973.694,99.81126;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;382;1926.385,-111.0543;Float;False;Property;_Secondarytexopacity;Secondary tex opacity;36;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;398;2003.809,1063.167;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;395;1969.326,881.6322;Float;False;Property;_Backgroundborderopacity;Background border opacity;34;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;400;2271.927,1171.165;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;388;2241.812,207.8089;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;392;2227.576,488.6739;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;396;2255.884,837.6321;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;384;2203.843,-153.7543;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;389;2400.369,99.81126;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;401;2430.485,1063.167;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;397;2414.442,729.6344;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;385;2362.401,-261.752;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;393;2386.135,380.6761;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;59;2762.453,373.7587;Float;True;5;5;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;374;4160.498,1128.016;Float;False;Property;_Globalopacity;Global opacity;33;0;Create;True;0;0;False;0;1;0.439;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;376;3031.919,698.629;Float;False;377;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;372;3003.096,522.9155;Float;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RegisterLocalVarNode;377;4443.461,1121.818;Float;False;Opacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;373;3261.377,627.9815;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;215;-1264.508,1618.066;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;216;-1095.355,1631.101;Float;True;BiggerCircleFull;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;375;3436.24,316.9993;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;371;3591.389,314.1487;Float;False;True;2;Float;AdultLink.RadialProgressBarEditor;0;5;AdultLink/RadialProgressBar/RadialProgressBar_UI;0f8ba0101102bb14ebf021ddadce9b49;0;0;SubShader 0 Pass 0;2;True;3;1;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;True;2;False;-1;False;False;True;2;False;-1;False;False;True;5;Queue=Transparent;IgnoreProjector=True;RenderType=Transparent;PreviewType=Plane;CanUseSpriteAtlas=True;False;0;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;286;-434.8913,3616.03;Float;False;643.9;272.5649;BG Fill Empty;0;BG Fill Empty;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;107;-2520.544,1931.904;Float;False;1425.286;534.8368;Mainbar Fill;0;Mainbar Fill;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;106;-2529.871,1255.103;Float;False;1730.515;589.2817;Bigger circle for border;0;Bigger circle for border;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;114;-2465.016,-259.4199;Float;False;2609.482;1113.476;Generate percentage masks;0;Generate percentage masks;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;166;4110.384,-318.449;Float;False;830.2405;1797.381;Parameters;0;Parameters;0.6764706,1,0.7590263,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;192;-428.2353,3226.427;Float;False;618.8071;323.468;BG Border ;0;BG Border ;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;111;5083.419,-299.1437;Float;False;954.1964;416.8591;Border color;0;Border color;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;169;-2666.874,2792.588;Float;False;1794.242;668.8176;Even bigger circle for BG;0;Even bigger circle for BG;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;238;5097.238,749.7537;Float;False;948.353;475.3962;Bar secondary color;0;Bar secondary color;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;163;-603.3226,1716.62;Float;False;736.1537;360.9658;Main bar Border;0;Main bar Border;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;293;-2541.062,3551.154;Float;False;1585.7;689.2803;Background Fill;0;Background Fill;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;102;-4340.141,174.8326;Float;False;601.5515;366.3412;Scaling to make the bar fit;0;Scaling;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;112;5090.387,225.4276;Float;False;920.9249;437.3615;Bar color;0;Bar color;1,1,1,1;0;0
WireConnection;183;0;182;0
WireConnection;138;0;48;0
WireConnection;74;0;75;0
WireConnection;74;1;159;0
WireConnection;74;2;190;0
WireConnection;104;0;74;0
WireConnection;11;0;1;0
WireConnection;11;3;104;0
WireConnection;11;4;74;0
WireConnection;404;0;402;0
WireConnection;403;0;11;0
WireConnection;403;2;404;0
WireConnection;26;0;403;0
WireConnection;204;0;203;0
WireConnection;28;0;26;0
WireConnection;105;0;30;0
WireConnection;140;0;10;0
WireConnection;296;0;251;0
WireConnection;23;0;28;1
WireConnection;23;1;28;0
WireConnection;205;0;204;0
WireConnection;332;0;120;0
WireConnection;357;0;116;0
WireConnection;295;0;70;0
WireConnection;29;0;23;0
WireConnection;29;1;105;0
WireConnection;29;2;30;0
WireConnection;258;0;259;0
WireConnection;214;0;142;0
WireConnection;214;1;213;0
WireConnection;208;0;207;0
WireConnection;186;0;170;0
WireConnection;186;1;184;0
WireConnection;252;0;296;0
WireConnection;12;0;11;0
WireConnection;339;0;119;0
WireConnection;339;1;332;0
WireConnection;349;0;115;0
WireConnection;349;1;357;0
WireConnection;340;0;334;0
WireConnection;360;0;45;0
WireConnection;341;0;119;0
WireConnection;341;1;332;0
WireConnection;342;0;119;0
WireConnection;342;1;336;0
WireConnection;350;0;115;0
WireConnection;350;1;358;0
WireConnection;361;0;85;0
WireConnection;348;0;115;0
WireConnection;348;1;357;0
WireConnection;347;0;346;0
WireConnection;157;0;295;0
WireConnection;289;0;29;0
WireConnection;277;0;274;0
WireConnection;135;0;12;0
WireConnection;273;0;265;0
WireConnection;273;1;258;0
WireConnection;302;0;214;0
WireConnection;302;1;303;0
WireConnection;36;0;141;0
WireConnection;36;4;208;0
WireConnection;290;0;29;0
WireConnection;172;0;186;0
WireConnection;103;0;139;0
WireConnection;279;0;278;0
WireConnection;279;1;277;0
WireConnection;351;0;348;0
WireConnection;351;1;350;0
WireConnection;351;2;347;0
WireConnection;352;0;349;0
WireConnection;352;2;360;0
WireConnection;352;1;355;0
WireConnection;65;0;302;0
WireConnection;344;0;339;0
WireConnection;344;1;342;0
WireConnection;344;2;340;0
WireConnection;343;0;341;0
WireConnection;343;2;361;0
WireConnection;343;1;337;0
WireConnection;209;0;290;0
WireConnection;209;1;273;0
WireConnection;173;0;171;0
WireConnection;173;1;172;0
WireConnection;362;0;93;0
WireConnection;94;0;117;0
WireConnection;94;1;118;0
WireConnection;255;0;289;0
WireConnection;255;1;258;0
WireConnection;218;0;158;0
WireConnection;218;1;36;0
WireConnection;218;2;304;0
WireConnection;292;0;29;0
WireConnection;133;0;15;0
WireConnection;210;0;209;0
WireConnection;51;0;137;0
WireConnection;51;1;103;0
WireConnection;175;0;173;0
WireConnection;281;0;280;0
WireConnection;281;1;274;0
WireConnection;281;2;278;0
WireConnection;176;0;174;0
WireConnection;176;1;186;0
WireConnection;176;2;171;0
WireConnection;96;0;94;0
WireConnection;96;2;362;0
WireConnection;96;1;95;0
WireConnection;282;0;279;0
WireConnection;256;0;255;0
WireConnection;33;0;29;0
WireConnection;33;1;218;0
WireConnection;353;1;352;0
WireConnection;353;0;351;0
WireConnection;353;2;349;0
WireConnection;345;1;343;0
WireConnection;345;0;344;0
WireConnection;345;2;341;0
WireConnection;66;0;292;0
WireConnection;66;1;65;0
WireConnection;167;0;97;0
WireConnection;38;1;353;0
WireConnection;89;1;345;0
WireConnection;16;0;136;0
WireConnection;283;0;282;0
WireConnection;179;0;175;0
WireConnection;257;0;256;0
WireConnection;14;0;134;0
WireConnection;14;1;136;0
WireConnection;49;0;51;0
WireConnection;284;0;281;0
WireConnection;177;0;176;0
WireConnection;46;0;132;0
WireConnection;46;1;139;0
WireConnection;46;2;137;0
WireConnection;211;0;210;0
WireConnection;67;0;66;0
WireConnection;34;0;33;0
WireConnection;92;1;96;0
WireConnection;407;0;38;1
WireConnection;98;0;92;0
WireConnection;98;1;168;0
WireConnection;414;0;89;3
WireConnection;413;0;89;2
WireConnection;405;0;38;3
WireConnection;406;0;38;2
WireConnection;145;0;34;0
WireConnection;19;0;14;0
WireConnection;412;0;89;1
WireConnection;260;0;212;0
WireConnection;260;1;284;0
WireConnection;260;2;283;0
WireConnection;180;0;261;0
WireConnection;180;1;177;0
WireConnection;180;2;179;0
WireConnection;50;0;49;0
WireConnection;17;0;16;0
WireConnection;146;0;67;0
WireConnection;47;0;46;0
WireConnection;181;0;180;0
WireConnection;52;0;149;0
WireConnection;52;1;47;0
WireConnection;52;2;50;0
WireConnection;408;0;407;0
WireConnection;408;1;406;0
WireConnection;408;2;405;0
WireConnection;408;3;38;4
WireConnection;415;0;412;0
WireConnection;415;1;413;0
WireConnection;415;2;414;0
WireConnection;415;3;89;4
WireConnection;246;0;98;0
WireConnection;20;0;147;0
WireConnection;20;1;19;0
WireConnection;20;2;17;0
WireConnection;262;0;260;0
WireConnection;409;0;38;0
WireConnection;409;1;408;0
WireConnection;150;0;20;0
WireConnection;151;0;52;0
WireConnection;417;0;89;0
WireConnection;417;1;415;0
WireConnection;247;0;98;0
WireConnection;247;1;246;0
WireConnection;189;0;181;0
WireConnection;189;1;262;0
WireConnection;420;1;247;0
WireConnection;420;0;419;0
WireConnection;418;1;417;0
WireConnection;418;0;416;0
WireConnection;411;1;409;0
WireConnection;411;0;410;0
WireConnection;217;0;189;0
WireConnection;236;0;233;0
WireConnection;236;1;235;0
WireConnection;236;2;234;0
WireConnection;285;0;262;0
WireConnection;285;1;240;0
WireConnection;73;0;71;0
WireConnection;73;1;72;0
WireConnection;73;2;144;0
WireConnection;6;0;8;0
WireConnection;6;1;7;0
WireConnection;6;2;143;0
WireConnection;160;0;151;0
WireConnection;160;1;150;0
WireConnection;127;0;420;0
WireConnection;131;0;411;0
WireConnection;126;0;418;0
WireConnection;121;0;73;0
WireConnection;237;0;236;0
WireConnection;223;0;285;0
WireConnection;229;0;230;0
WireConnection;191;0;217;0
WireConnection;161;0;160;0
WireConnection;194;0;193;0
WireConnection;123;0;6;0
WireConnection;91;0;129;0
WireConnection;91;1;128;0
WireConnection;91;2;154;0
WireConnection;91;3;241;0
WireConnection;195;0;196;0
WireConnection;195;1;197;0
WireConnection;39;0;156;0
WireConnection;39;1;130;0
WireConnection;39;2;124;0
WireConnection;221;0;228;0
WireConnection;221;1;231;0
WireConnection;57;0;122;0
WireConnection;57;1;162;0
WireConnection;390;0;39;0
WireConnection;394;0;195;0
WireConnection;383;0;91;0
WireConnection;386;0;57;0
WireConnection;398;0;221;0
WireConnection;400;0;398;3
WireConnection;400;1;399;0
WireConnection;388;0;386;3
WireConnection;388;1;387;0
WireConnection;392;0;390;3
WireConnection;392;1;391;0
WireConnection;396;0;394;3
WireConnection;396;1;395;0
WireConnection;384;0;383;3
WireConnection;384;1;382;0
WireConnection;389;0;386;0
WireConnection;389;1;386;1
WireConnection;389;2;386;2
WireConnection;389;3;388;0
WireConnection;401;0;398;0
WireConnection;401;1;398;1
WireConnection;401;2;398;2
WireConnection;401;3;400;0
WireConnection;397;0;394;0
WireConnection;397;1;394;1
WireConnection;397;2;394;2
WireConnection;397;3;396;0
WireConnection;385;0;383;0
WireConnection;385;1;383;1
WireConnection;385;2;383;2
WireConnection;385;3;384;0
WireConnection;393;0;390;0
WireConnection;393;1;390;1
WireConnection;393;2;390;2
WireConnection;393;3;392;0
WireConnection;59;0;385;0
WireConnection;59;1;389;0
WireConnection;59;2;393;0
WireConnection;59;3;397;0
WireConnection;59;4;401;0
WireConnection;372;0;59;0
WireConnection;377;0;374;0
WireConnection;373;0;372;3
WireConnection;373;1;376;0
WireConnection;215;0;47;0
WireConnection;215;1;50;0
WireConnection;216;0;215;0
WireConnection;375;0;372;0
WireConnection;375;1;372;1
WireConnection;375;2;372;2
WireConnection;375;3;373;0
WireConnection;371;0;375;0
ASEEND*/
//CHKSM=321ED6069FECF6E157D30F231022F740D7DDCDD9