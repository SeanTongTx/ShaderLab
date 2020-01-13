Shader "Lapis/Effect/Fresnel_Blend" {
    Properties {
        _Texture ("Texture", 2D) = "white" {}
        [HDR]_Color ("Color", Color) = (0.5,0.5,0.5,1)
        [HDR]_OutlineColor ("Outline Color", Color) = (0.8632076,0.9240042,1,1)
        _Rank ("Rank", Range(0, 5)) = 2.393162
        _Opacity ("Opacity", Float ) = 0
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
            #pragma target 3.0
            uniform float4 _OutlineColor;
            uniform float _Rank;
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
            uniform float4 _Color;
            uniform float _Opacity;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(i.uv0, _Texture));
                float3 emissive = ((_OutlineColor.rgb*pow(1.0-max(0,dot(normalDirection, viewDirection)),_Rank))+(_Texture_var.rgb*_Color.rgb));
                float3 finalColor = emissive;
                return fixed4(finalColor,_Opacity);
            }
            ENDCG
        }
    }
			Fallback "Hidden/Lapis/VertexLit"
}
