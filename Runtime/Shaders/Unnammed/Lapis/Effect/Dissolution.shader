
Shader "Lapis/Effect/Dissolution" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _DissTex ("DissTex", 2D) = "white" {}
        [HDR]_LineColor ("LineColor", Color) = (0.715676,1,0.4858491,1)
        _Diss ("Diss", Range(0, 1)) = 0
        _LineRank ("LineRank", Range(0, 1)) = 1
        _LineInt ("LineInt", Range(0, 1)) = 0.9316239
        [MaterialToggle] _UVSwitch ("UV Switch", Float ) = 1
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }
        Pass {
            Cull Off
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Diss;
            uniform sampler2D _DissTex; uniform float4 _DissTex_ST;
            uniform float _LineRank;
            uniform float4 _LineColor;
            uniform float _LineInt;
            uniform fixed _UVSwitch;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 _DissTex_var = tex2D(_DissTex,TRANSFORM_TEX(i.uv0, _DissTex));
                float node_5118 = ((_DissTex_var.g/(_Diss*2.0+0.0))*lerp( 1.0, i.uv1.g, _UVSwitch ));
                clip(node_5118 - 0.5);
////// Lighting:
////// Emissive:
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 emissive = _MainTex_var.rgb;
                float node_4754_if_leA = step(node_5118,_LineRank);
                float node_4754_if_leB = step(_LineRank,node_5118);
                float node_3269 = 1.0;
                float3 finalColor = emissive + (_LineColor.rgb*_LineInt*lerp((node_4754_if_leA*node_3269)+(node_4754_if_leB*0.0),node_3269,node_4754_if_leA*node_4754_if_leB));
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
			Fallback "Hidden/Lapis/VertexLit"
}
