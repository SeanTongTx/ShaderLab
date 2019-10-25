Shader "ShaderLab/Lapis/Effect/RotAdd" {
    Properties {
        [HDR]_COLOR ("COLOR", Color) = (1,1,1,1)
        _MainTex ("MainTex", 2D) = "white" {}
        _Ins ("Ins", Range(-1, 1)) = -0.3
        _MaskTex ("MaskTex", 2D) = "white" {}
        _Value ("Value", Float ) = 3
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Ins;
            uniform sampler2D _MaskTex; uniform float4 _MaskTex_ST;
            uniform float _Value;
            uniform float4 _COLOR;
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
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );


				float4 node_7686 = _Time;
				float node_8482_ang = node_7686.g;
				float node_8482_spd = _Ins;
				float node_8482_cos = cos(node_8482_spd*node_8482_ang);
				float node_8482_sin = sin(node_8482_spd*node_8482_ang);
				float2 node_8482_piv = float2(0.5, 0.5);
				float2 node_8482 = (mul(v.texcoord0 - node_8482_piv, float2x2(node_8482_cos, -node_8482_sin, node_8482_sin, node_8482_cos)) + node_8482_piv);

				o.uv0 = TRANSFORM_TEX(node_8482, _MainTex);
				o.uv1 = TRANSFORM_TEX(v.texcoord0, _MaskTex);

                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR 
			{
                float4 _MainTex_var = tex2D(_MainTex,i.uv0);
                float4 _MaskTex_var = tex2D(_MaskTex,i.uv1);

                float3 emissive = (i.vertexColor.rgb*(_MainTex_var.rgb*_MaskTex_var.rgb*_Value)*_COLOR.rgb);
                float3 finalColor = emissive;
                float MainTex_A = _MainTex_var.a;
                fixed4 finalRGBA = fixed4(finalColor,(MainTex_A*_MaskTex_var.r*_COLOR.a*i.vertexColor.a));
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
