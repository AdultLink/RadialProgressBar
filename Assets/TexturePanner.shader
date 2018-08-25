// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "AdultLink/TexturePanner"
{
	Properties
	{
		[NoScaleOffset]_Tex("Tex", 2D) = "white" {}
		[NoScaleOffset]_Masktexture("Mask texture", 2D) = "white" {}
		_Tiling("Tiling", Vector) = (1,1,0,0)
		_Offset("Offset", Vector) = (0,0,0,0)
		[HDR]_Color("Color", Color) = (0,0,0,0)
		[KeywordEnum(Original,Hueshift,Multiply,Replace)] _Colormode("Color mode", Float) = 2
		[Toggle]_Globalemissionflicker("Global emission flicker", Float) = 0
		_Globalemissionflickeramplitude("Global emission flicker amplitude", Float) = 0.5
		_Globalemissionflickerfreq("Global emission flicker freq", Float) = 1
		_Globalemissionflickeroffset("Global emission flicker offset", Float) = 1
		[Toggle]_ScanlinesY("Scanlines Y", Float) = 0
		[Toggle]_ScanlinesZ("Scanlines Z", Float) = 0
		[Toggle]_ScanlinesX("Scanlines X", Float) = 0
		_ScanlinesscaleZ("Scanlines scale Z", Float) = 30
		_ScanlinesscaleX("Scanlines scale X", Float) = 30
		_ScanlinesscaleY("Scanlines scale Y", Float) = 30
		_ScanlinesspeedX("Scanlines speed X", Float) = -5
		_ScanlinesspeedY("Scanlines speed Y", Float) = -5
		_ScanlinesspeedZ("Scanlines speed Z", Float) = -5
		[Toggle]_SharpY("SharpY", Float) = 1
		[Toggle]_SharpZ("SharpZ", Float) = 1
		[Toggle]_SharpX("SharpX", Float) = 1
		_ScrollingspeedX("Scrolling speed X", Float) = -1
		_ScrollingspeedY("Scrolling speed Y", Float) = 0
		[Toggle]_Horizontalstretch("Horizontalstretch", Float) = 0
		[Toggle]_Verticalstretch("Vertical stretch", Float) = 0
		_Horizontalstretchamplitude("Horizontal stretch amplitude", Range( 0 , 1)) = 0.5
		_Verticalstretchamplitude("Vertical stretch amplitude", Range( 0 , 1)) = 0.5
		_Horizontalstretchfreq("Horizontal stretch freq", Float) = 0.5
		_Verticalstretchfreq("Vertical stretch freq", Float) = 0.5
		_Horizontalstretchoffset("Horizontal stretch offset", Float) = 0
		_Verticalstretchoffset("Vertical stretch offset", Float) = 0
		_Verticalstretchpivotpoint("Vertical stretch pivot point", Range( -1 , 1)) = -0.06438866
		_Horizontalstretchpivotpoint("Horizontal stretch pivot point", Range( -1 , 1)) = 0
		[Toggle]_Horizontalmovement("Horizontalmovement", Float) = 0
		[Toggle]_Verticalmovement("Vertical movement", Float) = 0
		_Horizontalmovementamplitude("Horizontal movement amplitude", Float) = 0.5
		_Verticalmovementamplitude("Vertical movement amplitude", Float) = 0.5
		_Horizontalmovementfreq("Horizontal movement freq", Float) = 1
		_Verticalmovementfreq("Vertical movement freq", Float) = 1
		_Horizontalmovementoffset("Horizontal movement offset", Float) = 0
		_Verticalmovementoffset("Vertical movement offset", Float) = 0
		_RotationSpeed("Rotation Speed", Float) = 1
		_Masktexturerotationspeed("Mask texture rotation speed", Float) = 0
		[KeywordEnum(Scroll,Rotate,None)] _Scrollrotate("Scroll rotate", Float) = 0
		_Masktexturetiling("Mask texture tiling", Vector) = (1,1,0,0)
		_Masktextureoffset("Mask texture offset", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _COLORMODE_ORIGINAL _COLORMODE_HUESHIFT _COLORMODE_MULTIPLY _COLORMODE_REPLACE
		#pragma shader_feature _SCROLLROTATE_SCROLL _SCROLLROTATE_ROTATE _SCROLLROTATE_NONE
		#pragma surface surf Standard alpha:fade keepalpha noshadow vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform float _Horizontalmovement;
		uniform float _Horizontalmovementfreq;
		uniform float _Horizontalmovementamplitude;
		uniform float _Horizontalmovementoffset;
		uniform float _Horizontalstretch;
		uniform float _Horizontalstretchfreq;
		uniform float _Horizontalstretchamplitude;
		uniform float _Horizontalstretchoffset;
		uniform float _Horizontalstretchpivotpoint;
		uniform float _Verticalmovement;
		uniform float _Verticalmovementfreq;
		uniform float _Verticalmovementamplitude;
		uniform float _Verticalmovementoffset;
		uniform float _Verticalstretch;
		uniform float _Verticalstretchfreq;
		uniform float _Verticalstretchamplitude;
		uniform float _Verticalstretchoffset;
		uniform float _Verticalstretchpivotpoint;
		uniform float _Globalemissionflicker;
		uniform float _Globalemissionflickerfreq;
		uniform float _Globalemissionflickeramplitude;
		uniform float _Globalemissionflickeroffset;
		uniform float _ScanlinesX;
		uniform float _SharpX;
		uniform float _ScanlinesscaleX;
		uniform float _ScanlinesspeedX;
		uniform float _ScanlinesY;
		uniform float _SharpY;
		uniform float _ScanlinesscaleY;
		uniform float _ScanlinesspeedY;
		uniform float _ScanlinesZ;
		uniform float _SharpZ;
		uniform float _ScanlinesscaleZ;
		uniform float _ScanlinesspeedZ;
		uniform sampler2D _Tex;
		uniform float _ScrollingspeedX;
		uniform float _ScrollingspeedY;
		uniform float2 _Tiling;
		uniform float2 _Offset;
		uniform float _RotationSpeed;
		uniform float4 _Color;
		uniform sampler2D _Masktexture;
		uniform float2 _Masktexturetiling;
		uniform float2 _Masktextureoffset;
		uniform float _Masktexturerotationspeed;


		float3 HSVToRGB( float3 c )
		{
			float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
		}


		float3 RGBToHSV(float3 c)
		{
			float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
			float4 p = lerp( float4( c.bg, K.wz ), float4( c.gb, K.xy ), step( c.b, c.g ) );
			float4 q = lerp( float4( p.xyw, c.r ), float4( c.r, p.yzx ), step( p.x, c.r ) );
			float d = q.x - min( q.w, q.y );
			float e = 1.0e-10;
			return float3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
		}

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float mulTime201 = _Time.y * _Horizontalmovementfreq;
			float HorizontalMovement212 = lerp(0.0,(sin( mulTime201 )*_Horizontalmovementamplitude + _Horizontalmovementoffset),_Horizontalmovement);
			float mulTime190 = _Time.y * _Horizontalstretchfreq;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 Vertexpos163 = ase_vertex3Pos;
			float HorizontalStretch217 = lerp(0.0,( (sin( mulTime190 )*_Horizontalstretchamplitude + _Horizontalstretchoffset) * ( _Horizontalstretchpivotpoint + Vertexpos163.x ) ),_Horizontalstretch);
			float mulTime111 = _Time.y * _Verticalmovementfreq;
			float VerticalMovement210 = lerp(0.0,(sin( mulTime111 )*_Verticalmovementamplitude + _Verticalmovementoffset),_Verticalmovement);
			float mulTime91 = _Time.y * _Verticalstretchfreq;
			float VerticalStretch215 = lerp(0.0,( (sin( mulTime91 )*_Verticalstretchamplitude + _Verticalstretchoffset) * ( _Verticalstretchpivotpoint + Vertexpos163.y ) ),_Verticalstretch);
			float4 appendResult86 = (float4(( HorizontalMovement212 + HorizontalStretch217 ) , ( VerticalMovement210 + VerticalStretch215 ) , 0.0 , 0.0));
			v.vertex.xyz += appendResult86.xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float mulTime99 = _Time.y * _Globalemissionflickerfreq;
			float EmissionFlicker228 = lerp(1.0,(pow( sin( mulTime99 ) , 2.0 )*(0.0 + (_Globalemissionflickeramplitude - 0.0) * (0.1 - 0.0) / (1.0 - 0.0)) + _Globalemissionflickeroffset),_Globalemissionflicker);
			float mulTime147 = _Time.y * _ScanlinesspeedX;
			float clampResult150 = clamp( sin( (i.uv_texcoord.x*_ScanlinesscaleX + mulTime147) ) , 0.0 , 1.0 );
			float ScanlinesX220 = lerp(1.0,lerp(clampResult150,ceil( clampResult150 ),_SharpX),_ScanlinesX);
			float mulTime26 = _Time.y * _ScanlinesspeedY;
			float clampResult175 = clamp( sin( (i.uv_texcoord.y*_ScanlinesscaleY + mulTime26) ) , 0.0 , 1.0 );
			float ScanlinesY222 = lerp(1.0,lerp(clampResult175,ceil( clampResult175 ),_SharpY),_ScanlinesY);
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float mulTime154 = _Time.y * _ScanlinesspeedZ;
			float clampResult157 = clamp( sin( (ase_vertex3Pos.z*_ScanlinesscaleZ + mulTime154) ) , 0.0 , 1.0 );
			float ScanlinesZ224 = lerp(1.0,lerp(clampResult157,ceil( clampResult157 ),_SharpZ),_ScanlinesZ);
			float2 appendResult70 = (float2(_ScrollingspeedX , _ScrollingspeedY));
			float2 temp_output_80_0 = (float2( 0,0 ) + (_Offset - float2( 0,0 )) * (float2( 1,1 ) - float2( 0,0 )) / (float2( 360,360 ) - float2( 0,0 )));
			float2 uv_TexCoord7 = i.uv_texcoord * _Tiling + temp_output_80_0;
			float2 panner4 = ( _Time.y * appendResult70 + uv_TexCoord7);
			float2 uv_TexCoord185 = i.uv_texcoord * _Tiling + temp_output_80_0;
			float mulTime181 = _Time.y * _RotationSpeed;
			float cos179 = cos( mulTime181 );
			float sin179 = sin( mulTime181 );
			float2 rotator179 = mul( uv_TexCoord185 - ( _Tiling * float2( 0.5,0.5 ) ) , float2x2( cos179 , -sin179 , sin179 , cos179 )) + ( _Tiling * float2( 0.5,0.5 ) );
			#if defined(_SCROLLROTATE_SCROLL)
				float2 staticSwitch187 = panner4;
			#elif defined(_SCROLLROTATE_ROTATE)
				float2 staticSwitch187 = rotator179;
			#elif defined(_SCROLLROTATE_NONE)
				float2 staticSwitch187 = uv_TexCoord7;
			#else
				float2 staticSwitch187 = panner4;
			#endif
			float4 PannedRotatedTexture231 = tex2D( _Tex, staticSwitch187 );
			float4 CombinedTexture41 = ( EmissionFlicker228 * ScanlinesX220 * ScanlinesY222 * ScanlinesZ224 * PannedRotatedTexture231 );
			float3 hsvTorgb125 = RGBToHSV( CombinedTexture41.rgb );
			float3 hsvTorgb126 = RGBToHSV( _Color.rgb );
			float3 hsvTorgb127 = HSVToRGB( float3(( hsvTorgb125.x + hsvTorgb126.x ),hsvTorgb125.y,hsvTorgb125.z) );
			float2 uv_TexCoord238 = i.uv_texcoord * _Masktexturetiling + _Masktextureoffset;
			float mulTime247 = _Time.y * _Masktexturerotationspeed;
			float cos248 = cos( mulTime247 );
			float sin248 = sin( mulTime247 );
			float2 rotator248 = mul( uv_TexCoord238 - ( _Masktexturetiling * float2( 0.5,0.5 ) ) , float2x2( cos248 , -sin248 , sin248 , cos248 )) + ( _Masktexturetiling * float2( 0.5,0.5 ) );
			float Masktexture241 = tex2D( _Masktexture, rotator248 ).a;
			float CombinedTexture_alpha51 = ( CombinedTexture41.a * Masktexture241 );
			#if defined(_COLORMODE_ORIGINAL)
				float4 staticSwitch40 = CombinedTexture41;
			#elif defined(_COLORMODE_HUESHIFT)
				float4 staticSwitch40 = float4( hsvTorgb127 , 0.0 );
			#elif defined(_COLORMODE_MULTIPLY)
				float4 staticSwitch40 = ( CombinedTexture41 * _Color );
			#elif defined(_COLORMODE_REPLACE)
				float4 staticSwitch40 = ( _Color * CombinedTexture_alpha51 );
			#else
				float4 staticSwitch40 = ( CombinedTexture41 * _Color );
			#endif
			float4 FinalEmission234 = staticSwitch40;
			o.Emission = FinalEmission234.rgb;
			o.Alpha = CombinedTexture_alpha51;
		}

		ENDCG
	}
	CustomEditor "TexturePannerEditor"
}
/*ASEBEGIN
Version=15500
527;100;1108;634;300.2557;1683.065;2.441918;False;False
Node;AmplifyShaderEditor.CommentaryNode;227;425.6968,1245.412;Float;False;2289.74;989.5819;Scanlines;34;166;226;146;147;145;163;18;161;154;162;224;222;220;159;153;120;160;139;152;176;158;151;157;150;175;156;17;149;148;155;23;24;26;25;Scanlines;0.9933063,1,0.5147059,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;162;840.3309,2112.589;Float;False;Property;_ScanlinesspeedZ;Scanlines speed Z;18;0;Create;True;0;0;False;0;-5;-5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;918.8353,1780.917;Float;False;Property;_ScanlinesspeedY;Scanlines speed Y;17;0;Create;True;0;0;False;0;-5;-10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;166;599.4207,1572.893;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;145;885.0799,1577.545;Float;False;Property;_ScanlinesspeedX;Scanlines speed X;16;0;Create;True;0;0;False;0;-5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;18;489.5215,1873.18;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;230;-1234.632,-328.0081;Float;False;1773.437;553.2421;Emission pulsation;10;228;118;104;177;178;102;103;107;99;100;Emission pulsation;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;233;-183.8634,-1440.349;Float;False;2082.516;778.5083;Panning & rotation;18;231;5;77;6;187;179;4;181;70;7;182;69;80;144;66;252;251;185;Panning & rotation;0.9393511,0.6617647,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;26;1128.392,1784.333;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;154;1052.426,2116.005;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;161;937.6439,2030.495;Float;False;Property;_ScanlinesscaleZ;Scanlines scale Z;13;0;Create;True;0;0;False;0;30;400;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;226;852.0496,1420.792;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;146;982.3948,1495.451;Float;False;Property;_ScanlinesscaleX;Scanlines scale X;14;0;Create;True;0;0;False;0;30;800;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;147;1097.177,1580.961;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;1013.61,1698.822;Float;False;Property;_ScanlinesscaleY;Scanlines scale Y;15;0;Create;True;0;0;False;0;30;12;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;155;1296.219,1944.076;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;77;-150.8268,-1122.481;Float;False;Property;_Offset;Offset;3;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ScaleAndOffsetNode;23;1290.625,1618.836;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;148;1302.806,1325.162;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;100;-1171.327,-231.1431;Float;False;Property;_Globalemissionflickerfreq;Global emission flicker freq;8;0;Create;True;0;0;False;0;1;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;69;211.2,-850.3376;Float;False;Property;_ScrollingspeedY;Scrolling speed Y;23;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;80;45.30689,-1116.208;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;360,360;False;3;FLOAT2;0,0;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;252;41.87466,-1256.764;Float;False;Constant;_Anchorbase2;Anchor base2;47;0;Create;True;0;0;False;0;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;144;53.98999,-1390.439;Float;False;Property;_Tiling;Tiling;2;0;Create;True;0;0;False;0;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;182;374.2679,-1179.568;Float;False;Property;_RotationSpeed;Rotation Speed;42;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;156;1500.728,1942.873;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;149;1505.921,1325.349;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;99;-887.2533,-228.052;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;66;211.7117,-938.4066;Float;False;Property;_ScrollingspeedX;Scrolling speed X;22;0;Create;True;0;0;False;0;-1;0.03;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;17;1495.132,1617.632;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;181;570.8676,-1175.369;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;414.7427,-1080.118;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;251;391.0666,-1277.477;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;6;435.6416,-764.5033;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;70;549.8122,-935.9994;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;185;390.6965,-1394.239;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;150;1682.908,1349.797;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;107;-694.8007,-228.7995;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;103;-1037.494,-120.4556;Float;False;Property;_Globalemissionflickeramplitude;Global emission flicker amplitude;7;0;Create;True;0;0;False;0;0.5;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;175;1687.115,1647.301;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;157;1699.545,1960.249;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;176;1860.685,1735.694;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;177;-516.514,-241.2349;Float;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;4;747.0575,-965.6644;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;179;780.2935,-1281.386;Float;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;178;-681.8959,-132.3647;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;158;1875.35,2047.762;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;102;-869.6512,91.29403;Float;False;Property;_Globalemissionflickeroffset;Global emission flicker offset;9;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;151;1878.748,1431.509;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;244;-1218.581,513.2891;Float;False;1598.994;754.0536;Masking;10;241;245;238;240;239;248;247;246;250;249;Masking;1,0.4191176,0.4191176,1;0;0
Node;AmplifyShaderEditor.ToggleSwitchNode;152;2041.691,1324.531;Float;False;Property;_SharpX;SharpX;21;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;187;1067.044,-1072.649;Float;False;Property;_Scrollrotate;Scroll rotate;44;0;Create;True;0;0;False;0;0;0;0;True;;KeywordEnum;3;Scroll;Rotate;None;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;104;-335.8601,-204.3116;Float;True;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;139;2033.131,1616.813;Float;False;Property;_SharpY;SharpY;19;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;160;2036.498,1942.054;Float;False;Property;_SharpZ;SharpZ;20;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;153;2263.041,1322.858;Float;False;Property;_ScanlinesX;Scanlines X;12;0;Create;True;0;0;False;0;0;2;0;FLOAT;1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;118;-32.87918,-218.4214;Float;False;Property;_Globalemissionflicker;Global emission flicker;6;0;Create;True;0;0;False;0;0;2;0;FLOAT;1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;120;2252.253,1615.141;Float;False;Property;_ScanlinesY;Scanlines Y;10;0;Create;True;0;0;False;0;0;2;0;FLOAT;1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;214;2975.383,-256.0301;Float;False;1863.849;1495.605;Mesh stretching;26;217;199;198;196;197;191;193;194;192;195;189;190;188;215;117;85;98;93;97;165;89;95;94;164;91;83;Mesh stretching;0.5441177,1,0.9434077,1;0;0
Node;AmplifyShaderEditor.Vector2Node;250;-1146.718,902.4733;Float;False;Constant;_Anchorbase;Anchor base;47;0;Create;True;0;0;False;0;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;246;-1154.144,1126.048;Float;False;Property;_Masktexturerotationspeed;Mask texture rotation speed;43;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;240;-1159.835,745.0869;Float;False;Property;_Masktextureoffset;Mask texture offset;46;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;239;-1149.267,590.3821;Float;False;Property;_Masktexturetiling;Mask texture tiling;45;0;Create;True;0;0;False;0;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ToggleSwitchNode;159;2257.847,1940.382;Float;False;Property;_ScanlinesZ;Scanlines Z;11;0;Create;True;0;0;False;0;0;2;0;FLOAT;1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;1321.483,-1099.03;Float;True;Property;_Tex;Tex;0;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;228;273.4326,-213.1511;Float;False;EmissionFlicker;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;83;3092.32,-100.7514;Float;False;Property;_Verticalstretchfreq;Vertical stretch freq;29;0;Create;True;0;0;False;0;0.5;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;238;-795.7751,637.4448;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;232;992.3198,-52.08911;Float;True;231;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;221;1120.449,-335.5167;Float;False;220;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;222;2465.134,1616.469;Float;False;ScanlinesY;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;209;2989.364,1494.601;Float;False;1533.392;692.1729;Mesh displacement;16;210;116;115;112;113;114;111;110;200;201;204;203;202;205;206;212;Mesh displacement;0.5450981,1,0.7176471,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;220;2480.138,1329.359;Float;False;ScanlinesX;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;225;1121.638,-147.2878;Float;False;224;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;229;1091.043,-432.3458;Float;False;228;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;231;1604.748,-1100.481;Float;False;PannedRotatedTexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;224;2476.789,1938.244;Float;False;ScanlinesZ;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;188;3081.202,591.6454;Float;False;Property;_Horizontalstretchfreq;Horizontal stretch freq;28;0;Create;True;0;0;False;0;0.5;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;223;1120.354,-240.7696;Float;False;222;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;249;-786.289,797.5501;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;247;-700.1393,1087.148;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;163;700.9886,1889.947;Float;False;Vertexpos;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;164;3363.826,294.967;Float;False;163;0;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;200;3051.084,1899.934;Float;False;Property;_Horizontalmovementfreq;Horizontal movement freq;38;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;189;3362.864,987.3641;Float;False;163;0;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;110;3063.53,1589.789;Float;False;Property;_Verticalmovementfreq;Vertical movement freq;39;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;108;1431.275,-274.5659;Float;True;5;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleTimeNode;190;3318.19,595.6635;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;91;3319.154,-96.73336;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;248;-489.3597,627.9729;Float;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;195;3509.56,861.2339;Float;False;Property;_Horizontalstretchpivotpoint;Horizontal stretch pivot point;33;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;193;3330.073,674.1356;Float;False;Property;_Horizontalstretchamplitude;Horizontal stretch amplitude;26;0;Create;True;0;0;False;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;192;3408.989,750.2566;Float;False;Property;_Horizontalstretchoffset;Horizontal stretch offset;30;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;3510.522,168.8386;Float;False;Property;_Verticalstretchpivotpoint;Vertical stretch pivot point;32;0;Create;True;0;0;False;0;-0.06438866;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;165;3551.325,299.7859;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SinOpNode;89;3511.131,-94.54929;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;41;1636.434,-279.667;Float;True;CombinedTexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;245;-201.5304,599.7588;Float;True;Property;_Masktexture;Mask texture;1;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;194;3550.363,992.183;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CommentaryNode;236;2196.726,-1433.18;Float;False;1715.297;862.4515;Color mixing;11;234;40;43;127;42;52;9;125;126;45;8;Color mixing;1,0.7205882,0.7205882,1;0;0
Node;AmplifyShaderEditor.SinOpNode;191;3510.168,597.8475;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;94;3331.036,-18.26009;Float;False;Property;_Verticalstretchamplitude;Vertical stretch amplitude;27;0;Create;True;0;0;False;0;0.5;0.05;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;201;3328.339,1905.752;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;95;3409.952,57.86059;Float;False;Property;_Verticalstretchoffset;Vertical stretch offset;31;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;111;3340.785,1595.608;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;114;3352.667,1674.081;Float;False;Property;_Verticalmovementamplitude;Vertical movement amplitude;37;0;Create;True;0;0;False;0;0.5;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;98;3830.288,152.4377;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;197;3829.326,844.8335;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;2233.637,-1010.426;Float;False;41;0;1;COLOR;0
Node;AmplifyShaderEditor.SinOpNode;112;3532.761,1597.792;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;196;3697.18,598.5145;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;113;3431.583,1750.201;Float;False;Property;_Verticalmovementoffset;Vertical movement offset;41;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;204;3340.221,1984.226;Float;False;Property;_Horizontalmovementamplitude;Horizontal movement amplitude;36;0;Create;True;0;0;False;0;0.5;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;203;3419.137,2060.345;Float;False;Property;_Horizontalmovementoffset;Horizontal movement offset;40;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;242;1920.817,-128.6838;Float;False;241;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;202;3520.315,1907.936;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;9;2247.342,-895.95;Float;False;Property;_Color;Color;4;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1.208,1.208,1.208,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;93;3698.142,-93.88229;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;241;124.5758,602.2068;Float;True;Masktexture;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;49;1886.013,-273.3295;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RGBToHSVNode;126;2675.914,-1174.285;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ScaleAndOffsetNode;115;3719.773,1598.459;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;205;3707.326,1908.603;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;4031.319,-101.0444;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;243;2129.473,-203.5934;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;198;4030.357,591.3524;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;125;2671.696,-1319.881;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ToggleSwitchNode;206;3929.131,1901.644;Float;False;Property;_Horizontalmovement;Horizontalmovement;34;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;199;4253.26,565.0033;Float;False;Property;_Horizontalstretch;Horizontalstretch;24;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;52;2628.526,-686.7146;Float;False;51;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;116;3970.986,1604.33;Float;False;Property;_Verticalmovement;Vertical movement;35;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;43;2952.299,-1285.791;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;117;4254.223,-127.3933;Float;False;Property;_Verticalstretch;Vertical stretch;25;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;51;2265.461,-208.8776;Float;True;CombinedTexture_alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;217;4507.409,575.889;Float;False;HorizontalStretch;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;213;1014.593,462.5721;Float;False;212;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;2964.254,-751.9165;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;216;1052.746,780.0424;Float;False;215;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;215;4515.266,-118.2983;Float;False;VerticalStretch;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;2962.414,-869.3669;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;212;4235.689,1906.504;Float;False;HorizontalMovement;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;211;1034.358,694.627;Float;False;210;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;218;1033.001,557.1856;Float;False;217;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;210;4225.365,1602.245;Float;False;VerticalMovement;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;127;3123.383,-1101.866;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;109;1313.185,699.4976;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;208;1311.464,538.4625;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;40;3410.547,-937.1257;Float;True;Property;_Colormode;Color mode;5;0;Create;True;0;0;False;0;0;2;2;True;;KeywordEnum;4;Original;Hueshift;Multiply;Replace;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;234;3661.186,-937.4822;Float;False;FinalEmission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;86;1534.306,596.2252;Float;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;235;1592.572,325.1346;Float;False;234;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;219;1525.314,455.4742;Float;False;51;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1909.041,321.5571;Float;False;True;2;Float;TexturePannerEditor;0;0;Standard;AdultLink/TexturePanner;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;26;0;25;0
WireConnection;154;0;162;0
WireConnection;226;0;166;1
WireConnection;147;0;145;0
WireConnection;155;0;18;3
WireConnection;155;1;161;0
WireConnection;155;2;154;0
WireConnection;23;0;166;2
WireConnection;23;1;24;0
WireConnection;23;2;26;0
WireConnection;148;0;226;0
WireConnection;148;1;146;0
WireConnection;148;2;147;0
WireConnection;80;0;77;0
WireConnection;156;0;155;0
WireConnection;149;0;148;0
WireConnection;99;0;100;0
WireConnection;17;0;23;0
WireConnection;181;0;182;0
WireConnection;7;0;144;0
WireConnection;7;1;80;0
WireConnection;251;0;144;0
WireConnection;251;1;252;0
WireConnection;70;0;66;0
WireConnection;70;1;69;0
WireConnection;185;0;144;0
WireConnection;185;1;80;0
WireConnection;150;0;149;0
WireConnection;107;0;99;0
WireConnection;175;0;17;0
WireConnection;157;0;156;0
WireConnection;176;0;175;0
WireConnection;177;0;107;0
WireConnection;4;0;7;0
WireConnection;4;2;70;0
WireConnection;4;1;6;0
WireConnection;179;0;185;0
WireConnection;179;1;251;0
WireConnection;179;2;181;0
WireConnection;178;0;103;0
WireConnection;158;0;157;0
WireConnection;151;0;150;0
WireConnection;152;0;150;0
WireConnection;152;1;151;0
WireConnection;187;1;4;0
WireConnection;187;0;179;0
WireConnection;187;2;7;0
WireConnection;104;0;177;0
WireConnection;104;1;178;0
WireConnection;104;2;102;0
WireConnection;139;0;175;0
WireConnection;139;1;176;0
WireConnection;160;0;157;0
WireConnection;160;1;158;0
WireConnection;153;1;152;0
WireConnection;118;1;104;0
WireConnection;120;1;139;0
WireConnection;159;1;160;0
WireConnection;5;1;187;0
WireConnection;228;0;118;0
WireConnection;238;0;239;0
WireConnection;238;1;240;0
WireConnection;222;0;120;0
WireConnection;220;0;153;0
WireConnection;231;0;5;0
WireConnection;224;0;159;0
WireConnection;249;0;239;0
WireConnection;249;1;250;0
WireConnection;247;0;246;0
WireConnection;163;0;18;0
WireConnection;108;0;229;0
WireConnection;108;1;221;0
WireConnection;108;2;223;0
WireConnection;108;3;225;0
WireConnection;108;4;232;0
WireConnection;190;0;188;0
WireConnection;91;0;83;0
WireConnection;248;0;238;0
WireConnection;248;1;249;0
WireConnection;248;2;247;0
WireConnection;165;0;164;0
WireConnection;89;0;91;0
WireConnection;41;0;108;0
WireConnection;245;1;248;0
WireConnection;194;0;189;0
WireConnection;191;0;190;0
WireConnection;201;0;200;0
WireConnection;111;0;110;0
WireConnection;98;0;97;0
WireConnection;98;1;165;1
WireConnection;197;0;195;0
WireConnection;197;1;194;0
WireConnection;112;0;111;0
WireConnection;196;0;191;0
WireConnection;196;1;193;0
WireConnection;196;2;192;0
WireConnection;202;0;201;0
WireConnection;93;0;89;0
WireConnection;93;1;94;0
WireConnection;93;2;95;0
WireConnection;241;0;245;4
WireConnection;49;0;41;0
WireConnection;126;0;9;0
WireConnection;115;0;112;0
WireConnection;115;1;114;0
WireConnection;115;2;113;0
WireConnection;205;0;202;0
WireConnection;205;1;204;0
WireConnection;205;2;203;0
WireConnection;85;0;93;0
WireConnection;85;1;98;0
WireConnection;243;0;49;3
WireConnection;243;1;242;0
WireConnection;198;0;196;0
WireConnection;198;1;197;0
WireConnection;125;0;42;0
WireConnection;206;1;205;0
WireConnection;199;1;198;0
WireConnection;116;1;115;0
WireConnection;43;0;125;1
WireConnection;43;1;126;1
WireConnection;117;1;85;0
WireConnection;51;0;243;0
WireConnection;217;0;199;0
WireConnection;45;0;9;0
WireConnection;45;1;52;0
WireConnection;215;0;117;0
WireConnection;8;0;42;0
WireConnection;8;1;9;0
WireConnection;212;0;206;0
WireConnection;210;0;116;0
WireConnection;127;0;43;0
WireConnection;127;1;125;2
WireConnection;127;2;125;3
WireConnection;109;0;211;0
WireConnection;109;1;216;0
WireConnection;208;0;213;0
WireConnection;208;1;218;0
WireConnection;40;1;42;0
WireConnection;40;0;127;0
WireConnection;40;2;8;0
WireConnection;40;3;45;0
WireConnection;234;0;40;0
WireConnection;86;0;208;0
WireConnection;86;1;109;0
WireConnection;0;2;235;0
WireConnection;0;9;219;0
WireConnection;0;11;86;0
ASEEND*/
//CHKSM=8E84189494C89EE376F331E889B096B011C9FE72