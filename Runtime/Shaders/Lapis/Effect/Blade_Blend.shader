
Shader "ShaderLab/Lapis/Effect/BladeBlend" {
    Properties {
        _Tex1 ("Tex1", 2D) = "white" {}
        _Mask ("Mask", 2D) = "white" {}
        _Color ("Color", Color) = (0.3345942,0.9716981,0.9542375,1)
        _Mut ("Mut", Float ) = 4
        _Tex1XSpeed ("Tex1 XSpeed", Float ) = 1
        _Tex1YSpeed ("Tex1 YSpeed", Float ) = 0
        _MaskXSpeed ("Mask XSpeed", Float ) = 0
        _MaskYSpeed ("Mask YSpeed", Float ) = 0
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma target 3.0
            uniform sampler2D _Tex1; uniform float4 _Tex1_ST;
            uniform sampler2D _Mask; uniform float4 _Mask_ST;
            uniform float4 _Color;
            uniform float _Mut;
            uniform float _Tex1XSpeed;
            uniform float _Tex1YSpeed;
            uniform float _MaskXSpeed;
            uniform float _MaskYSpeed;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
				float2 uv1 : TEXCOORD1;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );

				float Time = _Time.r;
				float2 node_9783 = ((float2(_Tex1XSpeed, _Tex1YSpeed)*Time) + v.texcoord0);
				float2 node_3276 = (v.texcoord0) + (Time*float2(_MaskXSpeed, _MaskYSpeed));
				o.uv0 = TRANSFORM_TEX(node_9783, _Tex1);
				o.uv1 = TRANSFORM_TEX(node_3276, _Mask);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR 
			{
                float4 _Tex1_var = tex2D(_Tex1,i.uv0);

                float3 finalColor = (_Color.rgb*_Mut*_Tex1_var.rgb);
                float4 _Mask_var = tex2D(_Mask, i.uv1);
                float node_9376 = (_Mask_var.r*i.vertexColor.a);
                return fixed4(finalColor,node_9376);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
