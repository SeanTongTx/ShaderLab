Shader "ShaderLab/Lapis/Effect/Disa" {
    Properties {
        _MainColor ("Main Color.", Color) = (1,1,1,1)
        _Main ("Main.", 2D) = "white" {}
        _MainIns ("Main Ins.", Range(0, 3)) = 1
        _Diss ("Diss", Range(-0.001, 1)) = 0.1701111
        _Vein ("Vein", 2D) = "white" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Blend One One
            Cull Off
            ZWrite Off
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float4 _MainColor;
            uniform sampler2D _Main; uniform float4 _Main_ST;
            uniform float _MainIns;
            uniform float _Diss;
            uniform sampler2D _Vein; uniform float4 _Vein_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
				float2 uv1 : TEXCOORD1;
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = TRANSFORM_TEX(v.texcoord0, _Vein);
				o.uv1 = TRANSFORM_TEX(v.texcoord0, _Main);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 _Vein_var = tex2D(_Vein, i.uv0);
                clip((_Diss/_Vein_var.r) - 0.5);
////// Lighting:
////// Emissive:
                float4 _Main_var = tex2D(_Main, i.uv1);
                float3 emissive = (_MainColor.rgb*_Main_var.rgb*_MainIns);
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,_Main_var.a);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
