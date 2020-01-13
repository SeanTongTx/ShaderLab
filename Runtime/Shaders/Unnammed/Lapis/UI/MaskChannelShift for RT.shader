// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)

Shader "Lapis/UI/MaskChannelShift for RT"
{
	Properties
	{
		[PerRendererData] _MainTex("Sprite Texture", 2D) = "white" {}
		_MaskTex("Sprite Texture", 2D) = "black" {}
		_Color("Tint", Color) = (1,1,1,1)

		_StencilComp("Stencil Comparison", Float) = 8
		_Stencil("Stencil ID", Float) = 0
		_StencilOp("Stencil Operation", Float) = 0
		_StencilWriteMask("Stencil Write Mask", Float) = 255
		_StencilReadMask("Stencil Read Mask", Float) = 255

		_ColorMask("Color Mask", Float) = 15

		_Shapen ("Shapen", 2D) = "white" {}
        _Distortion ("Distortion", Range(0, 1)) = 0
        _OffsetX ("OffsetX", Range(0, 1)) = 0.392599
        _OffsetY ("OffsetY", Range(0, 1)) = 0
        _Density ("Density", Range(0, 100)) = 15.38462
        _SpeedNoise ("SpeedNoise", Range(0, 1)) = 0.5974633

		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip("Use Alpha Clip", Float) = 0
	}

	SubShader
	{
		Tags
		{
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
			"PreviewType" = "Plane"
			"CanUseSpriteAtlas" = "True"
		}

		Stencil
		{
			Ref[_Stencil]
			Comp[_StencilComp]
			Pass[_StencilOp]
			ReadMask[_StencilReadMask]
			WriteMask[_StencilWriteMask]
		}

		Cull Off
		Lighting Off
		ZWrite Off
		ZTest[unity_GUIZTestMode]
		Blend One SrcAlpha
		ColorMask[_ColorMask]

		Pass
		{
			Name "Default"
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 2.0

			#include "UnityCG.cginc"
			#include "UnityUI.cginc"

			#pragma multi_compile __ UNITY_UI_CLIP_RECT
			#pragma multi_compile __ UNITY_UI_ALPHACLIP

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
				fixed4 color : COLOR;
				float2 texcoord  : TEXCOORD0;
				float4 worldPosition : TEXCOORD1;
				UNITY_VERTEX_OUTPUT_STEREO
			};

			fixed4 _Color;
			fixed4 _TextureSampleAdd;
			float4 _ClipRect;

			v2f vert(appdata_t v)
			{
				v2f OUT;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
				OUT.worldPosition = v.vertex;
				OUT.vertex = UnityObjectToClipPos(OUT.worldPosition);

				OUT.texcoord = v.texcoord;

				OUT.color = v.color * _Color;
				return OUT;
			}

			sampler2D _MainTex;
			sampler2D _MaskTex;

			uniform sampler2D _Shapen; uniform float4 _Shapen_ST;
			uniform float _Distortion;
			uniform float _OffsetX;
			uniform float _OffsetY;
			uniform float _Density;
			uniform float _SpeedNoise;


			fixed4 frag(v2f IN) : SV_Target
			{
				//shift
				float4 node_4548 = _Time;
				float2 node_1097 = (floor((IN.texcoord*1.0 + 1.0) * _Density) / (_Density - 1) + (node_4548.g*(_SpeedNoise*0.1 + 0.0)*0.001)*float2(0.1,0.1));
				float2 node_2206_skew = node_1097 + 0.2127 + node_1097.x*0.3713*node_1097.y;
				float2 node_2206_rnd = 4.789*sin(489.123*(node_2206_skew));
				float node_2206 = frac(node_2206_rnd.x*node_2206_rnd.y*(1 + node_2206_skew.x));
				float2 node_242 = (IN.texcoord + (node_4548.g*float2(_OffsetX,_OffsetY)) + node_2206);
				float4 _Shapen_var = tex2D(_Shapen,TRANSFORM_TEX(node_242, _Shapen));
				half4 color = (tex2D(_MainTex, IN.texcoord+ (_Shapen_var.rgb.rg*(_Distortion*0.02 + 0.0))) + _TextureSampleAdd) * IN.color;



				#ifdef UNITY_UI_CLIP_RECT
				color.a *= UnityGet2DClipping(IN.worldPosition.xy, _ClipRect);
				#endif

				half mask = tex2D(_MaskTex, IN.texcoord).a;
				color.rgb *= mask;

				



				color.a = max((1 - mask), color.a);

				#ifdef UNITY_UI_ALPHACLIP
				clip(color.a - 0.001);
				#endif

				return color;
			}
			ENDCG
		}
	}
}
