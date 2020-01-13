// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)

Shader "Lapis/UI/Default Blur"
{
    Properties
    {
        [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
        _Color ("Tint", Color) = (1,1,1,1)
		_BlurOffset ("Blur Offset", Range(0, 10)) = 10

        _StencilComp ("Stencil Comparison", Float) = 8
        _Stencil ("Stencil ID", Float) = 0
        _StencilOp ("Stencil Operation", Float) = 0
        _StencilWriteMask ("Stencil Write Mask", Float) = 255
        _StencilReadMask ("Stencil Read Mask", Float) = 255

        _ColorMask ("Color Mask", Float) = 15

        [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
    }

    SubShader
    {
        Tags
        {
            "Queue"="Transparent"
            "IgnoreProjector"="True"
            "RenderType"="Transparent"
            "PreviewType"="Plane"
            "CanUseSpriteAtlas"="True"
        }

        Stencil
        {
            Ref [_Stencil]
            Comp [_StencilComp]
            Pass [_StencilOp]
            ReadMask [_StencilReadMask]
            WriteMask [_StencilWriteMask]
        }

        Cull Off
        Lighting Off
        ZWrite Off
        ZTest [unity_GUIZTestMode]
        Blend SrcAlpha OneMinusSrcAlpha
        ColorMask [_ColorMask]

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
                fixed4 color    : COLOR;
                float4 worldPosition : TEXCOORD0;
				half2 texcoords[9] : TEXCOORD1;
                UNITY_VERTEX_OUTPUT_STEREO
            };

            sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _MainTex_TexelSize;

            fixed4 _Color;
            float4 _ClipRect;
			half _BlurOffset;

            v2f vert(appdata_t v)
            {
                v2f o;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
                o.worldPosition = v.vertex;
                o.vertex = UnityObjectToClipPos(o.worldPosition);

				half2 texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.texcoords[0] = texcoord;

				o.texcoords[1] = _MainTex_TexelSize.xy * _BlurOffset * half2(0, 1);
				o.texcoords[2] = _MainTex_TexelSize.xy * _BlurOffset * half2(0, -1);
				o.texcoords[3] = _MainTex_TexelSize.xy * _BlurOffset * half2(1, 0);
				o.texcoords[4] = _MainTex_TexelSize.xy * _BlurOffset * half2(-1, 0);

				o.texcoords[5] = _MainTex_TexelSize.xy * _BlurOffset * half2(1, 1);
				o.texcoords[6] = _MainTex_TexelSize.xy * _BlurOffset * half2(1, -1);
				o.texcoords[7] = _MainTex_TexelSize.xy * _BlurOffset * half2(-1, 1);
				o.texcoords[8] = _MainTex_TexelSize.xy * _BlurOffset * half2(-1, -1);

                o.color = v.color * _Color;

                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
				fixed4 color = 0;

				half2 texcoord = i.texcoords[0];

				color += tex2D(_MainTex, texcoord + i.texcoords[1]);
				color += tex2D(_MainTex, texcoord + i.texcoords[2]);
				color += tex2D(_MainTex, texcoord + i.texcoords[3]);
				color += tex2D(_MainTex, texcoord + i.texcoords[4]);
					 					 
				color += tex2D(_MainTex, texcoord + i.texcoords[5] * 0.75);
				color += tex2D(_MainTex, texcoord + i.texcoords[6] * 0.75);
				color += tex2D(_MainTex, texcoord + i.texcoords[7] * 0.75);
				color += tex2D(_MainTex, texcoord + i.texcoords[8] * 0.75);
					  					 
				color += tex2D(_MainTex, texcoord + i.texcoords[1] * 0.5);
				color += tex2D(_MainTex, texcoord + i.texcoords[2] * 0.5);
				color += tex2D(_MainTex, texcoord + i.texcoords[3] * 0.5);
				color += tex2D(_MainTex, texcoord + i.texcoords[4] * 0.5);
					  					 
				color += tex2D(_MainTex, texcoord + i.texcoords[5] * 0.25);
				color += tex2D(_MainTex, texcoord + i.texcoords[6] * 0.25);
				color += tex2D(_MainTex, texcoord + i.texcoords[7] * 0.25);
				color += tex2D(_MainTex, texcoord + i.texcoords[8] * 0.25);

				color *= 0.0625 * i.color;

                #ifdef UNITY_UI_CLIP_RECT
                color.a *= UnityGet2DClipping(i.worldPosition.xy, _ClipRect);
                #endif

                #ifdef UNITY_UI_ALPHACLIP
                clip (color.a - 0.001);
                #endif

                return color;
            }
        ENDCG
        }
    }
}
