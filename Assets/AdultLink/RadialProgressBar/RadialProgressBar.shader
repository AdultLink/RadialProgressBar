// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "AdultLink/RadialProgressBar/RadialProgressBar"
{
	Properties
	{
		_Radius("Radius", Range( 0 , 1)) = 0.3
		_Arcrange("Arc range", Range( 0 , 360)) = 360
		_Fillpercentage("Fill percentage", Range( 0 , 1)) = 0.25
		_Globalopacity("Global opacity", Range( 0 , 1)) = 1
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
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature _SECONDARYSCROLLROTATE_SCROLL _SECONDARYSCROLLROTATE_ROTATE _SECONDARYSCROLLROTATE_NONE
		#pragma shader_feature _MAINSCROLLROTATE_SCROLL _MAINSCROLLROTATE_ROTATE _MAINSCROLLROTATE_NONE
		struct Input
		{
			float2 uv_texcoord;
		};

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

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_output_332_0 = (float2( 0,0 ) + (_Secondarytexoffset - float2( 0,0 )) * (float2( 1,1 ) - float2( 0,0 )) / (float2( 360,360 ) - float2( 0,0 )));
			float2 uv_TexCoord341 = i.uv_texcoord * _Secondarytextiling + temp_output_332_0;
			float2 panner343 = ( _Time.y * (float2( 0,0 ) + (_Secondarytexscrollspeed - float2( 0,0 )) * (float2( 0.01,0.01 ) - float2( 0,0 )) / (float2( 1,1 ) - float2( 0,0 ))) + uv_TexCoord341);
			float2 uv_TexCoord339 = i.uv_texcoord * _Secondarytextiling + temp_output_332_0;
			float mulTime340 = _Time.y * _Secondarytexrotationspeed;
			float cos344 = cos( mulTime340 );
			float sin344 = sin( mulTime340 );
			float2 rotator344 = mul( uv_TexCoord339 - ( _Secondarytextiling * float2( 0.5,0.5 ) ) , float2x2( cos344 , -sin344 , sin344 , cos344 )) + ( _Secondarytextiling * float2( 0.5,0.5 ) );
			#if defined(_SECONDARYSCROLLROTATE_SCROLL)
				float2 staticSwitch345 = panner343;
			#elif defined(_SECONDARYSCROLLROTATE_ROTATE)
				float2 staticSwitch345 = rotator344;
			#elif defined(_SECONDARYSCROLLROTATE_NONE)
				float2 staticSwitch345 = uv_TexCoord341;
			#else
				float2 staticSwitch345 = panner343;
			#endif
			float4 tex2DNode89 = tex2D( _Secondarytex, staticSwitch345 );
			float4 appendResult399 = (float4(( 1.0 - tex2DNode89.r ) , ( 1.0 - tex2DNode89.g ) , ( 1.0 - tex2DNode89.b ) , tex2DNode89.a));
			float4 Secondarytexture126 = CalculateContrast(_Secondarytexcontrast,lerp(tex2DNode89,appendResult399,_Invertsecondarytex));
			float2 uv_TexCoord94 = i.uv_texcoord * _Noisetextiling + _Noisetexoffset;
			float2 panner96 = ( _Time.y * (float2( 0,0 ) + (_Noisetexspeed - float2( 0,0 )) * (float2( 0.01,0.01 ) - float2( 0,0 )) / (float2( 1,1 ) - float2( 0,0 ))) + uv_TexCoord94);
			float Noiseintensity167 = _Noiseintensity;
			float4 temp_output_98_0 = ( tex2D( _Noisetex, panner96 ) * Noiseintensity167 );
			float4 Noisetexture127 = CalculateContrast(_Noisetexcontrast,lerp(temp_output_98_0,( 1.0 - temp_output_98_0 ),_Invertnoisetex));
			float MainbarBorderwidth138 = _Mainborderradialwidth;
			float BackgroundBorderWidth183 = _Backgroundborderradialwidth;
			float2 temp_output_74_0 = ( float2( 1,1 ) + MainbarBorderwidth138 + BackgroundBorderWidth183 );
			float2 temp_output_11_0 = (-temp_output_74_0 + (i.uv_texcoord - float2( 0,0 )) * (temp_output_74_0 - -temp_output_74_0) / (float2( 1,1 ) - float2( 0,0 )));
			float cos383 = cos( radians( _Rotation ) );
			float sin383 = sin( radians( _Rotation ) );
			float2 rotator383 = mul( temp_output_11_0 - float2( 0,0 ) , float2x2( cos383 , -sin383 , sin383 , cos383 )) + float2( 0,0 );
			float2 break28 = (rotator383).xy;
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
			float4 break363 = ( Secondarytexture126 * Noisetexture127 * MainbarFill150 * BarSecondaryColor237 );
			float4 appendResult364 = (float4(break363.r , break363.g , break363.b , ( break363.a * _Secondarytexopacity )));
			float4 lerpResult73 = lerp( _Bordermincolor , _Bordermaxcolor , Fillpercentage140);
			float4 Bordercolor121 = lerpResult73;
			float MainbarBorderPercentage146 = ceil( ( temp_output_29_0 - (1.0 + (( ( Fillpercentage140 * ArcRange205 ) - BorderWidth3252 ) - 0.0) * (0.0 - 1.0) / (1.0 - 0.0)) ) );
			float temp_output_47_0 = floor( ( BarRadius133 + MainbarBorderwidth138 + Length135 ) );
			float temp_output_50_0 = ( 1.0 - floor( ( Length135 + -MainbarBorderwidth138 ) ) );
			float Biggercircle151 = ( MainbarBorderPercentage146 * temp_output_47_0 * temp_output_50_0 );
			float MainbarBorder161 = ( Biggercircle151 - MainbarFill150 );
			float4 break367 = ( Bordercolor121 * MainbarBorder161 );
			float4 appendResult368 = (float4(break367.r , break367.g , break367.b , ( break367.a * _Mainbarborderopacity )));
			float2 temp_output_357_0 = (float2( 0,0 ) + (_Maintexoffset - float2( 0,0 )) * (float2( 1,1 ) - float2( 0,0 )) / (float2( 360,360 ) - float2( 0,0 )));
			float2 uv_TexCoord349 = i.uv_texcoord * _Maintextiling + temp_output_357_0;
			float2 panner352 = ( _Time.y * (float2( 0,0 ) + (_Maintexscrollspeed - float2( 0,0 )) * (float2( 0.01,0.01 ) - float2( 0,0 )) / (float2( 1,1 ) - float2( 0,0 ))) + uv_TexCoord349);
			float2 uv_TexCoord348 = i.uv_texcoord * _Maintextiling + temp_output_357_0;
			float mulTime347 = _Time.y * _Maintexrotationspeed;
			float cos351 = cos( mulTime347 );
			float sin351 = sin( mulTime347 );
			float2 rotator351 = mul( uv_TexCoord348 - ( _Maintextiling * float2( 0.5,0.5 ) ) , float2x2( cos351 , -sin351 , sin351 , cos351 )) + ( _Maintextiling * float2( 0.5,0.5 ) );
			#if defined(_MAINSCROLLROTATE_SCROLL)
				float2 staticSwitch353 = panner352;
			#elif defined(_MAINSCROLLROTATE_ROTATE)
				float2 staticSwitch353 = rotator351;
			#elif defined(_MAINSCROLLROTATE_NONE)
				float2 staticSwitch353 = uv_TexCoord349;
			#else
				float2 staticSwitch353 = panner352;
			#endif
			float4 tex2DNode38 = tex2D( _Maintex, staticSwitch353 );
			float4 appendResult390 = (float4(( 1.0 - tex2DNode38.r ) , ( 1.0 - tex2DNode38.g ) , ( 1.0 - tex2DNode38.b ) , tex2DNode38.a));
			float4 Maintexture131 = CalculateContrast(_Maintexcontrast,lerp(tex2DNode38,appendResult390,_Invertmaintex));
			float4 lerpResult6 = lerp( _Barmincolor , _Barmaxcolor , Fillpercentage140);
			float4 BarColor123 = lerpResult6;
			float4 break371 = ( MainbarFill150 * Maintexture131 * BarColor123 );
			float4 appendResult372 = (float4(break371.r , break371.g , break371.b , ( break371.a * _Maintexopacity )));
			float temp_output_258_0 = (1.0 + (ArcRange205 - 0.0) * (0.0 - 1.0) / (1.0 - 0.0));
			float BackgroundBorderPercentage257 = ceil( ( temp_output_29_0 - temp_output_258_0 ) );
			float temp_output_186_0 = ( MainbarBorderwidth138 + BackgroundBorderWidth183 );
			float Background181 = ( BackgroundBorderPercentage257 * floor( ( BarRadius133 + temp_output_186_0 + Length135 ) ) * ( 1.0 - floor( ( Length135 + -temp_output_186_0 ) ) ) );
			float BackgroundFillPercentage211 = ceil( ( temp_output_29_0 - ( BorderWidth3252 + temp_output_258_0 ) ) );
			float BackgroundFillFull262 = ( BackgroundFillPercentage211 * floor( ( BarRadius133 + MainbarBorderwidth138 + Length135 ) ) * ( 1.0 - floor( ( Length135 + -MainbarBorderwidth138 ) ) ) );
			float clampResult217 = clamp( ( Background181 - BackgroundFillFull262 ) , 0.0 , 1.0 );
			float BackgroundBorder191 = clampResult217;
			float4 BGColor194 = _Backgroundbordercolor;
			float4 break375 = ( BackgroundBorder191 * BGColor194 );
			float4 appendResult376 = (float4(break375.r , break375.g , break375.b , ( break375.a * _Backgroundborderopacity )));
			float BackgroundFillEmpty223 = ( BackgroundFillFull262 - Biggercircle151 );
			float4 BackgroundFillColor229 = _Backgroundfillcolor;
			float4 break379 = ( BackgroundFillEmpty223 * BackgroundFillColor229 );
			float4 appendResult380 = (float4(break379.r , break379.g , break379.b , ( break379.a * _Backgroundopacity )));
			float4 temp_output_59_0 = ( appendResult364 + appendResult368 + appendResult372 + appendResult376 + appendResult380 );
			o.Emission = temp_output_59_0.xyz;
			float Opacity202 = _Globalopacity;
			o.Alpha = ( temp_output_59_0.w * Opacity202 );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "AdultLink.RadialProgressBarEditor"
}
/*ASEBEGIN
Version=15500
438;92;1092;348;-3332.222;382.7643;2.023965;True;False
Node;AmplifyShaderEditor.CommentaryNode;166;4110.384,-318.449;Float;False;830.2405;1797.381;Parameters;25;157;252;296;295;202;200;229;194;230;193;167;97;133;15;140;70;205;251;10;204;203;138;183;48;182;Parameters;0.6764706,1,0.7590263,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;102;-4279.354,227.2327;Float;False;601.5515;366.3412;Scaling to make the bar fit;5;104;74;190;75;159;Scaling;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;48;4159.64,-241.3051;Float;False;Property;_Mainborderradialwidth;Main border radial width;10;0;Create;True;0;0;False;0;0;0.033;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;182;4172.921,619.031;Float;False;Property;_Backgroundborderradialwidth;Background border radial width;13;0;Create;True;0;0;False;0;0;0.036;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;190;-4253.044,501.192;Float;False;183;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;75;-4229.979,283.8664;Float;False;Constant;_Vector0;Vector 0;11;0;Create;True;0;0;False;0;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RegisterLocalVarNode;138;4436.015,-241.4851;Float;False;MainbarBorderwidth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;159;-4249.177,418.0688;Float;False;138;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;183;4466.886,620.6659;Float;False;BackgroundBorderWidth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;74;-3995.521,341.1722;Float;False;3;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NegateNode;104;-3868.833,277.0524;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;385;-3094.652,368.8411;Float;False;Property;_Rotation;Rotation;39;0;Create;True;0;0;False;0;0;0;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-3959.517,-300.0638;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;11;-3451.722,237.9933;Float;True;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-1,-1;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RadiansOpNode;384;-2810.43,370.29;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;114;-2465.016,-259.4199;Float;False;2609.482;1113.476;Generate percentage masks;38;158;141;208;207;142;213;259;257;258;256;255;218;145;34;33;146;67;66;65;214;29;289;36;23;105;30;28;26;209;210;211;290;273;265;292;304;303;302;Generate percentage masks;1,1,1,1;0;0
Node;AmplifyShaderEditor.RotatorNode;383;-2649.22,262.5374;Float;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;203;4160.519,1236.924;Float;False;Property;_Arcrange;Arc range;1;0;Create;True;0;0;False;0;360;360;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;26;-2348.671,323.6691;Float;True;True;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;108;-2533.18,-3249.152;Float;False;3414.006;886.1533;Main texture;24;390;392;391;131;386;387;388;389;38;353;352;351;349;350;360;355;347;348;115;346;45;358;357;116;Main texture;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;109;-2500.13,-2111.351;Float;False;3419.362;822.0753;Secondary texture;24;126;397;398;396;399;395;394;393;89;345;344;343;340;341;337;339;342;361;336;119;332;334;85;120;Secondary texture;1,1,1,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;28;-2098.829,324.9987;Float;True;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;251;4149.741,271.6759;Float;False;Property;_Backgroundbordertangentwidth;Background border tangent width;12;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;30;-1946.094,647.7456;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;4155.891,-45.327;Float;False;Property;_Fillpercentage;Fill percentage;2;0;Create;True;0;0;False;0;0.25;0.957;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;169;-2521.104,2675.972;Float;False;1794.242;668.8176;Even bigger circle for BG;14;261;181;180;177;179;175;176;174;173;172;171;186;170;184;Even bigger circle for BG;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;204;4448.803,1241.844;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;360;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;105;-1739.124,685.3541;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;170;-2473.393,2939.016;Float;False;138;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;293;-2521.626,3541.436;Float;False;1585.7;689.2803;Background Fill;12;262;260;212;283;284;282;281;279;280;278;277;274;Background Fill;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;205;4632.683,1231.785;Float;False;ArcRange;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;4153.716,61.35442;Float;False;Property;_Mainbordertangentwidth;Main border tangent width;11;0;Create;True;0;0;False;0;0;0.145;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;296;4469.235,289.0914;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.05;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;207;-2007.468,120.3304;Float;False;205;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;140;4444.837,-46.52695;Float;False;Fillpercentage;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;184;-2477.656,3040.785;Float;False;183;0;1;FLOAT;0
Node;AmplifyShaderEditor.ATan2OpNode;23;-1813.874,324.8884;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;116;-2475.495,-2887.585;Float;False;Property;_Maintexoffset;Main tex offset;19;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;213;-1467.342,680.778;Float;False;205;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;259;-1138.713,135.584;Float;False;205;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;142;-1489.249,599.0247;Float;False;140;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;120;-2427.222,-1738.93;Float;False;Property;_Secondarytexoffset;Secondary tex offset;23;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TFHCRemapNode;357;-2241.104,-2884.217;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;360,360;False;3;FLOAT2;0,0;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;214;-1227.301,609.2108;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;265;-963.3506,-101.0643;Float;False;252;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;274;-2475.789,3793.261;Float;False;138;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;106;-2529.871,1255.103;Float;False;1730.515;589.2817;Bigger circle for border;14;216;215;151;52;149;47;50;46;49;132;51;137;103;139;Bigger circle for border;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;110;-2466.373,-1093.642;Float;False;2290.036;534.5397;Noise texture;15;405;127;404;247;246;98;168;92;96;94;362;95;93;118;117;Noise texture;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;141;-1785.429,43.17583;Float;False;140;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;358;-2249.863,-3026.549;Float;False;Constant;_Anchorbase;Anchor base;47;0;Create;True;0;0;False;0;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;45;-2073.793,-2661.525;Float;False;Property;_Maintexscrollspeed;Main tex scroll speed;17;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;346;-1848.193,-2925.93;Float;False;Property;_Maintexrotationspeed;Main tex rotation speed;30;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;258;-958.3196,142.1667;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;208;-1791.658,127.2541;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;186;-2182.263,3002.33;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;303;-1483.998,768.8998;Float;False;252;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;29;-1543.135,359.6689;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;332;-2142.205,-1734.335;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;360,360;False;3;FLOAT2;0,0;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;252;4646.44,290.4834;Float;False;BorderWidth3;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;12;-3092.89,520.769;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;119;-2195.948,-2022.933;Float;False;Property;_Secondarytextiling;Secondary tex tiling;22;0;Create;True;0;0;False;0;0,0;0.5,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;115;-2244.709,-3171.219;Float;False;Property;_Maintextiling;Main tex tiling;18;0;Create;True;0;0;False;0;0,0;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TFHCRemapNode;295;4447.873,73.40568;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.05;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;85;-2057.838,-1544.187;Float;False;Property;_Secondarytexscrollspeed;Secondary tex scroll speed;21;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;336;-2150.966,-1876.667;Float;False;Constant;_Anchorbase2;Anchor base2;47;0;Create;True;0;0;False;0;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;334;-1785.144,-1792.539;Float;False;Property;_Secondarytexrotationspeed;Secondary tex rotation speed;31;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;277;-2175.323,3971.675;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;135;-2916.357,512.1612;Float;True;Length;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;171;-1992.442,3028.038;Float;False;135;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;304;-1150.411,467.7894;Float;False;252;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;302;-1070.292,752.7352;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;348;-1767.831,-3162.248;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;157;4624.759,72.02412;Float;False;Borderwidth2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;347;-1585.162,-2931.016;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;289;-1163.404,84.09908;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;355;-1791.734,-2490.553;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;360;-1789.927,-2679.608;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;0,0;False;4;FLOAT2;0.01,0.01;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;350;-1767.46,-3045.486;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;158;-1549.128,47.98973;Float;False;157;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;36;-1570.776,127.432;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;349;-1812.333,-2809.82;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;93;-2408.838,-751.7086;Float;False;Property;_Noisetexspeed;Noise tex speed;26;0;Create;True;0;0;False;0;0,0;-0.5,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;339;-1689.667,-2012.365;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;342;-1689.297,-1895.604;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;117;-2431.366,-1025.917;Float;False;Property;_Noisetextiling;Noise tex tiling;27;0;Create;True;0;0;False;0;0,0;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;118;-2435.985,-905.0771;Float;False;Property;_Noisetexoffset;Noise tex offset;28;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.NegateNode;172;-1990.866,3104.674;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;4156.279,-144.9161;Float;False;Property;_Radius;Radius;0;0;Create;True;0;0;False;0;0.3;0.381;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;273;-748.0826,-92.72653;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;139;-2509.071,1398.734;Float;False;138;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;278;-2176.898,3895.039;Float;False;135;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;290;-1280.2,-159.6177;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;340;-1491.661,-1793.561;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;341;-1732.814,-1686.387;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;337;-1697.863,-1385.057;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;361;-1698.254,-1561.982;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;0,0;False;4;FLOAT2;0.01,0.01;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;65;-842.91,637.4735;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;95;-2122.113,-675.4991;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;209;-605.8688,-138.4702;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;107;-2520.544,1931.904;Float;False;1425.286;534.8368;Mainbar Fill;9;150;20;147;17;19;16;14;134;136;Mainbar Fill;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;174;-2260.209,2838.024;Float;False;133;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;173;-1807.22,3081.537;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;133;4429.807,-143.6881;Float;False;BarRadius;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;218;-795.887,438.9902;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;255;-605.4991,94.28665;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;137;-2227.285,1463.243;Float;False;135;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;344;-1300.069,-1899.512;Float;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;351;-1378.232,-3049.395;Float;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;343;-1333.305,-1583.791;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;362;-2126.645,-851.6413;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;0,0;False;4;FLOAT2;0.01,0.01;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;94;-2160.067,-989.6006;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;280;-2444.667,3705.025;Float;False;133;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;279;-1991.676,3948.538;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;352;-1411.469,-2733.673;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;292;-1261.835,515.8734;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;103;-2203.931,1583.437;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;96;-1806.692,-890.8979;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;33;-603.7076,337.7349;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;51;-2020.285,1560.299;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;282;-1870.69,3950.29;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;175;-1686.234,3083.289;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;136;-2473.071,2119.291;Float;False;135;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;66;-606.8147,573.4583;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;-2473.275,1316.786;Float;False;133;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;134;-2470.613,1987.59;Float;False;133;0;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;210;-397.3276,-138.7356;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;4169.984,499.3177;Float;False;Property;_Noiseintensity;Noise intensity;29;0;Create;True;0;0;False;0;5;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;345;-1032.276,-1724.899;Float;False;Property;_Secondaryscrollrotate;Secondary scroll rotate;33;0;Create;True;0;0;False;0;0;0;2;True;;KeywordEnum;3;Scroll;Rotate;None;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;353;-1085.791,-2866.279;Float;False;Property;_Mainscrollrotate;Main scroll rotate;32;0;Create;True;0;0;False;0;0;0;0;True;;KeywordEnum;3;Scroll;Rotate;None;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CeilOpNode;256;-396.9577,94.02127;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;281;-1945.452,3709.678;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;176;-1760.996,2842.677;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;67;-393.7538,573.2755;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;46;-1974.062,1321.438;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;92;-1610.334,-935.8924;Float;True;Property;_Noisetex;Noise tex;24;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FloorOpNode;284;-1694.176,3709.098;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;283;-1678.023,3962.475;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;179;-1493.566,3095.474;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;212;-1771.832,3607.058;Float;False;211;0;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;16;-2213.207,2217.397;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;261;-1579.801,2737.934;Float;False;257;0;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;177;-1509.719,2842.097;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;89;-727.5134,-1746.45;Float;True;Property;_Secondarytex;Secondary tex;20;1;[NoScaleOffset];Create;True;0;0;False;0;None;6a35c1fbda267f042864c469d8d0136f;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;257;-259.8394,88.93338;Float;True;BackgroundBorderPercentage;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;211;-256.1796,-143.8235;Float;True;BackgroundFillPercentage;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;38;-816.8794,-2891.46;Float;True;Property;_Maintex;Main tex;16;1;[NoScaleOffset];Create;True;0;0;False;0;None;6a35c1fbda267f042864c469d8d0136f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-2236.631,1990.623;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;168;-1537.618,-739.3766;Float;False;167;0;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;49;-1899.3,1562.051;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;167;4365.541,499.7834;Float;False;Noiseintensity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;34;-394.7443,337.3792;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;260;-1365.313,3767.693;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;146;-261.1469,568.8488;Float;True;MainbarBorderPercentage;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;17;-1986.393,2218.228;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;389;-329.6659,-2722.758;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;180;-1134.968,2895.503;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;395;-320.0743,-1692.282;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;394;-321.4373,-1626.559;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;50;-1706.632,1574.236;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;19;-1987.305,1990.043;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;147;-1735.686,1991.772;Float;False;145;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;387;-331.0289,-2853.998;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;47;-1722.785,1320.858;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;145;-261.643,332.954;Float;True;MainbarFillPercentage;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;388;-332.392,-2788.275;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;149;-1518.75,1296.566;Float;False;146;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;-1293.375,-934.1053;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;393;-318.7112,-1561.042;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;192;-428.2353,3226.427;Float;False;618.8071;323.468;BG Border ;3;191;217;189;BG Border ;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;286;-434.8913,3616.03;Float;False;643.9;272.5649;BG Fill Empty;3;223;285;240;BG Fill Empty;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;111;5083.419,-299.1437;Float;False;954.1964;416.8591;Border color;5;121;73;71;144;72;Border color;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-1507.063,2178.498;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;246;-1074.645,-865.1874;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;262;-1211.367,3745.028;Float;True;BackgroundFillFull;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;-1241.511,1401.763;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;181;-971.3315,2877.657;Float;True;Background;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;112;5090.387,225.4276;Float;False;920.9249;437.3615;Bar color;5;7;8;143;6;123;Bar color;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;238;5097.238,749.7537;Float;False;948.353;475.3962;Bar secondary color;5;233;237;235;234;236;Bar secondary color;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;399;-74.94312,-1468.216;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;390;-85.89774,-2629.932;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;71;5149.703,-241.8233;Float;False;Property;_Bordermincolor;Border min color;8;1;[HDR];Create;True;0;0;False;0;1,0,0,1;0.8161765,0,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;163;-603.3226,1716.62;Float;False;736.1537;360.9658;Main bar Border;2;161;160;Main bar Border;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;392;126.3791,-2906.653;Float;False;Property;_Maintexcontrast;Main tex contrast;44;0;Create;True;0;0;False;0;1;0.8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;405;-873.8342,-825.0989;Float;False;Property;_Noisetexcontrast;Noise tex contrast;42;0;Create;True;0;0;False;0;1;0.8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;247;-896.5735,-942.2323;Float;False;Property;_Invertnoisetex;Invertnoisetex;25;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;7;5138.596,458.229;Float;False;Property;_Barmaxcolor;Bar max color;5;1;[HDR];Create;True;0;0;False;0;0,1,0.08965516,1;0.02897927,0.985294,0.3125737,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;386;107.0049,-3011.141;Float;False;Property;_Invertmaintex;Invert main tex;41;0;Create;True;0;0;False;0;0;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;189;-417.7115,3279.102;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;240;-414.3459,3805.728;Float;False;151;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;233;5118.678,805.0606;Float;False;Property;_Barsecondarymincolor;Bar secondary min color;6;1;[HDR];Create;True;0;0;False;0;1,0,0,1;1,0.3517228,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;398;137.3336,-1722.54;Float;False;Property;_Secondarytexcontrast;Secondary tex contrast;43;0;Create;True;0;0;False;0;1;0.8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;8;5141.837,286.4486;Float;False;Property;_Barmincolor;Bar min color;4;1;[HDR];Create;True;0;0;False;0;1,0,0,1;1,0,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;144;5411.979,24.92087;Float;False;140;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;72;5141.84,-64.39629;Float;False;Property;_Bordermaxcolor;Border max color;9;1;[HDR];Create;True;0;0;False;0;0,1,0.08965516,1;0.01113755,0.7573529,0.2324284,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;150;-1348.128,2173.948;Float;True;MainbarFill;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;234;5386.121,1058.323;Float;False;140;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;151;-1077.876,1395.799;Float;True;Biggercircle;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;235;5117.557,974.7197;Float;False;Property;_Barsecondarymaxcolor;Bar secondary max color;7;1;[HDR];Create;True;0;0;False;0;0,1,0.08965516,1;0.04876726,0.6029412,0.3728181,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;396;117.9595,-1849.425;Float;False;Property;_Invertsecondarytex;Invert secondary tex;40;0;Create;True;0;0;False;0;0;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;143;5377.892,552.5139;Float;False;140;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;230;4169.206,939.5326;Float;False;Property;_Backgroundfillcolor;Background fill color;15;1;[HDR];Create;True;0;0;False;0;0.2132353,0.6418865,1,1;0.117647,0.3403769,0.5,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;193;4170.672,727.4504;Float;False;Property;_Backgroundbordercolor;Background border color;14;1;[HDR];Create;True;0;0;False;0;0.2132353,0.6418865,1,1;0.04919874,0.5807034,0.9558824,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleContrastOpNode;391;347.6679,-2990.952;Float;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;404;-648.5456,-931.3989;Float;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;160;-568.2471,1782.769;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;73;5643.618,-144.2223;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;397;413.7489,-1837.85;Float;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;6;5601.794,408.4546;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;165;1593.126,-322.5731;Float;False;2361.214;1646.966;Final composition;43;329;199;201;250;59;39;221;195;57;91;231;162;130;156;241;197;196;124;122;129;154;228;128;363;365;364;366;367;368;369;370;371;372;373;374;375;376;377;378;379;380;381;382;Final composition;0.6470588,0.8539554,1,1;0;0
Node;AmplifyShaderEditor.ClampOpNode;217;-203.8913,3286.892;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;285;-194.1326,3662.843;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;236;5618.143,914.2628;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;131;555.5276,-3013.776;Float;True;Maintexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;162;1659.27,179.0179;Float;False;161;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;128;1673.666,-183.3448;Float;False;127;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;197;1638.817,887.6539;Float;False;194;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;130;1655.952,491.6533;Float;False;131;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;123;5757.844,403.2677;Float;True;BarColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;196;1642.305,800.2861;Float;False;191;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;228;1629.419,1078.442;Float;False;223;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;124;1654.776,580.838;Float;False;123;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;241;1648.02,-25.43773;Float;False;237;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;191;-53.09107,3282.352;Float;True;BackgroundBorder;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;229;4420.258,937.9106;Float;False;BackgroundFillColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;121;5798.399,-143.9892;Float;True;Bordercolor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;129;1672.331,-265.8067;Float;False;126;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;127;-442.403,-938.6656;Float;True;Noisetexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;156;1657.419,409.1373;Float;False;150;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;161;-221.9629,1766.11;Float;True;MainbarBorder;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;194;4428.448,731.2079;Float;False;BGColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;237;5774.193,909.0757;Float;True;BarSecondaryColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;223;-52.65546,3657.94;Float;True;BackgroundFillEmpty;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;122;1659.439,87.21303;Float;False;121;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;154;1673.218,-102.2038;Float;False;150;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;231;1629.267,1162.169;Float;False;229;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;126;634.9465,-1840.954;Float;True;Secondarytexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;195;1969.586,766.1198;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;221;1969.21,1079.232;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;1996.723,-166.8117;Float;True;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;1986.676,462.0992;Float;True;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;1996.282,92.29397;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;363;2224.973,-248.7206;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;365;2206.533,-96.72286;Float;False;Property;_Secondarytexopacity;Secondary tex opacity;36;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;375;2213.059,763.5303;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;374;2203.819,599.1994;Float;False;Property;_Maintexopacity;Main tex opacity;37;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;379;2224.819,1070.176;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;370;2216.536,241.6744;Float;False;Property;_Mainbarborderopacity;Main bar border opacity;38;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;378;2194.619,915.5281;Float;False;Property;_Backgroundborderopacity;Background border opacity;34;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;367;2243.377,86.87624;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;371;2222.259,447.2015;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;382;2206.379,1222.174;Float;False;Property;_Backgroundopacity;Background opacity;35;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;377;2481.177,871.528;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;373;2490.377,555.1993;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;369;2511.495,194.8739;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;366;2493.091,-140.7229;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;381;2492.937,1178.174;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;368;2670.053,86.87624;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;380;2651.495,1070.176;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;364;2651.649,-248.7206;Float;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;376;2639.735,763.5303;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;372;2648.935,447.2015;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;59;2969.604,388.1165;Float;True;5;5;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;200;4160.548,1137.74;Float;False;Property;_Globalopacity;Global opacity;3;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;201;3262.655,623.9467;Float;False;202;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;250;3226.577,454.4566;Float;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RegisterLocalVarNode;202;4467.624,1133.009;Float;False;Opacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;199;3490.985,546.9207;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;216;-1095.355,1631.101;Float;True;BiggerCircleFull;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;215;-1264.508,1618.066;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;329;3694.098,336.0615;Float;False;True;2;Float;AdultLink.RadialProgressBarEditor;0;0;Standard;AdultLink/RadialProgressBar/RadialProgressBar;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;138;0;48;0
WireConnection;183;0;182;0
WireConnection;74;0;75;0
WireConnection;74;1;159;0
WireConnection;74;2;190;0
WireConnection;104;0;74;0
WireConnection;11;0;1;0
WireConnection;11;3;104;0
WireConnection;11;4;74;0
WireConnection;384;0;385;0
WireConnection;383;0;11;0
WireConnection;383;2;384;0
WireConnection;26;0;383;0
WireConnection;28;0;26;0
WireConnection;204;0;203;0
WireConnection;105;0;30;0
WireConnection;205;0;204;0
WireConnection;296;0;251;0
WireConnection;140;0;10;0
WireConnection;23;0;28;1
WireConnection;23;1;28;0
WireConnection;357;0;116;0
WireConnection;214;0;142;0
WireConnection;214;1;213;0
WireConnection;258;0;259;0
WireConnection;208;0;207;0
WireConnection;186;0;170;0
WireConnection;186;1;184;0
WireConnection;29;0;23;0
WireConnection;29;1;105;0
WireConnection;29;2;30;0
WireConnection;332;0;120;0
WireConnection;252;0;296;0
WireConnection;12;0;11;0
WireConnection;295;0;70;0
WireConnection;277;0;274;0
WireConnection;135;0;12;0
WireConnection;302;0;214;0
WireConnection;302;1;303;0
WireConnection;348;0;115;0
WireConnection;348;1;357;0
WireConnection;157;0;295;0
WireConnection;347;0;346;0
WireConnection;289;0;29;0
WireConnection;360;0;45;0
WireConnection;350;0;115;0
WireConnection;350;1;358;0
WireConnection;36;0;141;0
WireConnection;36;4;208;0
WireConnection;349;0;115;0
WireConnection;349;1;357;0
WireConnection;339;0;119;0
WireConnection;339;1;332;0
WireConnection;342;0;119;0
WireConnection;342;1;336;0
WireConnection;172;0;186;0
WireConnection;273;0;265;0
WireConnection;273;1;258;0
WireConnection;290;0;29;0
WireConnection;340;0;334;0
WireConnection;341;0;119;0
WireConnection;341;1;332;0
WireConnection;361;0;85;0
WireConnection;65;0;302;0
WireConnection;209;0;290;0
WireConnection;209;1;273;0
WireConnection;173;0;171;0
WireConnection;173;1;172;0
WireConnection;133;0;15;0
WireConnection;218;0;158;0
WireConnection;218;1;36;0
WireConnection;218;2;304;0
WireConnection;255;0;289;0
WireConnection;255;1;258;0
WireConnection;344;0;339;0
WireConnection;344;1;342;0
WireConnection;344;2;340;0
WireConnection;351;0;348;0
WireConnection;351;1;350;0
WireConnection;351;2;347;0
WireConnection;343;0;341;0
WireConnection;343;2;361;0
WireConnection;343;1;337;0
WireConnection;362;0;93;0
WireConnection;94;0;117;0
WireConnection;94;1;118;0
WireConnection;279;0;278;0
WireConnection;279;1;277;0
WireConnection;352;0;349;0
WireConnection;352;2;360;0
WireConnection;352;1;355;0
WireConnection;292;0;29;0
WireConnection;103;0;139;0
WireConnection;96;0;94;0
WireConnection;96;2;362;0
WireConnection;96;1;95;0
WireConnection;33;0;29;0
WireConnection;33;1;218;0
WireConnection;51;0;137;0
WireConnection;51;1;103;0
WireConnection;282;0;279;0
WireConnection;175;0;173;0
WireConnection;66;0;292;0
WireConnection;66;1;65;0
WireConnection;210;0;209;0
WireConnection;345;1;343;0
WireConnection;345;0;344;0
WireConnection;345;2;341;0
WireConnection;353;1;352;0
WireConnection;353;0;351;0
WireConnection;353;2;349;0
WireConnection;256;0;255;0
WireConnection;281;0;280;0
WireConnection;281;1;274;0
WireConnection;281;2;278;0
WireConnection;176;0;174;0
WireConnection;176;1;186;0
WireConnection;176;2;171;0
WireConnection;67;0;66;0
WireConnection;46;0;132;0
WireConnection;46;1;139;0
WireConnection;46;2;137;0
WireConnection;92;1;96;0
WireConnection;284;0;281;0
WireConnection;283;0;282;0
WireConnection;179;0;175;0
WireConnection;16;0;136;0
WireConnection;177;0;176;0
WireConnection;89;1;345;0
WireConnection;257;0;256;0
WireConnection;211;0;210;0
WireConnection;38;1;353;0
WireConnection;14;0;134;0
WireConnection;14;1;136;0
WireConnection;49;0;51;0
WireConnection;167;0;97;0
WireConnection;34;0;33;0
WireConnection;260;0;212;0
WireConnection;260;1;284;0
WireConnection;260;2;283;0
WireConnection;146;0;67;0
WireConnection;17;0;16;0
WireConnection;389;0;38;3
WireConnection;180;0;261;0
WireConnection;180;1;177;0
WireConnection;180;2;179;0
WireConnection;395;0;89;1
WireConnection;394;0;89;2
WireConnection;50;0;49;0
WireConnection;19;0;14;0
WireConnection;387;0;38;1
WireConnection;47;0;46;0
WireConnection;145;0;34;0
WireConnection;388;0;38;2
WireConnection;98;0;92;0
WireConnection;98;1;168;0
WireConnection;393;0;89;3
WireConnection;20;0;147;0
WireConnection;20;1;19;0
WireConnection;20;2;17;0
WireConnection;246;0;98;0
WireConnection;262;0;260;0
WireConnection;52;0;149;0
WireConnection;52;1;47;0
WireConnection;52;2;50;0
WireConnection;181;0;180;0
WireConnection;399;0;395;0
WireConnection;399;1;394;0
WireConnection;399;2;393;0
WireConnection;399;3;89;4
WireConnection;390;0;387;0
WireConnection;390;1;388;0
WireConnection;390;2;389;0
WireConnection;390;3;38;4
WireConnection;247;0;98;0
WireConnection;247;1;246;0
WireConnection;386;0;38;0
WireConnection;386;1;390;0
WireConnection;189;0;181;0
WireConnection;189;1;262;0
WireConnection;150;0;20;0
WireConnection;151;0;52;0
WireConnection;396;0;89;0
WireConnection;396;1;399;0
WireConnection;391;1;386;0
WireConnection;391;0;392;0
WireConnection;404;1;247;0
WireConnection;404;0;405;0
WireConnection;160;0;151;0
WireConnection;160;1;150;0
WireConnection;73;0;71;0
WireConnection;73;1;72;0
WireConnection;73;2;144;0
WireConnection;397;1;396;0
WireConnection;397;0;398;0
WireConnection;6;0;8;0
WireConnection;6;1;7;0
WireConnection;6;2;143;0
WireConnection;217;0;189;0
WireConnection;285;0;262;0
WireConnection;285;1;240;0
WireConnection;236;0;233;0
WireConnection;236;1;235;0
WireConnection;236;2;234;0
WireConnection;131;0;391;0
WireConnection;123;0;6;0
WireConnection;191;0;217;0
WireConnection;229;0;230;0
WireConnection;121;0;73;0
WireConnection;127;0;404;0
WireConnection;161;0;160;0
WireConnection;194;0;193;0
WireConnection;237;0;236;0
WireConnection;223;0;285;0
WireConnection;126;0;397;0
WireConnection;195;0;196;0
WireConnection;195;1;197;0
WireConnection;221;0;228;0
WireConnection;221;1;231;0
WireConnection;91;0;129;0
WireConnection;91;1;128;0
WireConnection;91;2;154;0
WireConnection;91;3;241;0
WireConnection;39;0;156;0
WireConnection;39;1;130;0
WireConnection;39;2;124;0
WireConnection;57;0;122;0
WireConnection;57;1;162;0
WireConnection;363;0;91;0
WireConnection;375;0;195;0
WireConnection;379;0;221;0
WireConnection;367;0;57;0
WireConnection;371;0;39;0
WireConnection;377;0;375;3
WireConnection;377;1;378;0
WireConnection;373;0;371;3
WireConnection;373;1;374;0
WireConnection;369;0;367;3
WireConnection;369;1;370;0
WireConnection;366;0;363;3
WireConnection;366;1;365;0
WireConnection;381;0;379;3
WireConnection;381;1;382;0
WireConnection;368;0;367;0
WireConnection;368;1;367;1
WireConnection;368;2;367;2
WireConnection;368;3;369;0
WireConnection;380;0;379;0
WireConnection;380;1;379;1
WireConnection;380;2;379;2
WireConnection;380;3;381;0
WireConnection;364;0;363;0
WireConnection;364;1;363;1
WireConnection;364;2;363;2
WireConnection;364;3;366;0
WireConnection;376;0;375;0
WireConnection;376;1;375;1
WireConnection;376;2;375;2
WireConnection;376;3;377;0
WireConnection;372;0;371;0
WireConnection;372;1;371;1
WireConnection;372;2;371;2
WireConnection;372;3;373;0
WireConnection;59;0;364;0
WireConnection;59;1;368;0
WireConnection;59;2;372;0
WireConnection;59;3;376;0
WireConnection;59;4;380;0
WireConnection;250;0;59;0
WireConnection;202;0;200;0
WireConnection;199;0;250;3
WireConnection;199;1;201;0
WireConnection;216;0;215;0
WireConnection;215;0;47;0
WireConnection;215;1;50;0
WireConnection;329;2;59;0
WireConnection;329;9;199;0
ASEEND*/
//CHKSM=57C01AEE1C09DAC4828996A72CD4DEEE8D720128