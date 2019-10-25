
Shader "ShaderLab/Lapis/Effect/Dissolution_Blend" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _Mask ("Mask", 2D) = "white" {}
        _Dissolution ("Dissolution",  Range(0,1)) = 0.3
        [HDR]_MainColor ("MainColor", Color) = (1,1,1,1)
        _OutLineRang ("OutLine Rang",  Range(0,1)) = 0.01
        [HDR]_OutLineColor ("OutLine Color", Color) = (1,0,0,1)
        _MainVSpeed ("Main VSpeed", Float ) = 0
        _MainUSpeed ("Main USpeed", Float ) = 0
        _MaskUSpeed ("Mask USpeed", Float ) = 0
        _MaskVSpeed ("Mask VSpeed", Float ) = 0
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
            uniform sampler2D _Mask; uniform float4 _Mask_ST;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float4 _MainColor;
            uniform float _Dissolution;
            uniform float _OutLineRang;
            uniform float4 _OutLineColor;
            uniform float _MainVSpeed;
            uniform float _MainUSpeed;
            uniform float _MaskUSpeed;
            uniform float _MaskVSpeed;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
////// Emissive:
                float4 node_970 = _Time;
                float2 node_8387 = ((float2(_MainUSpeed,_MainVSpeed)*node_970.g)+i.uv0);
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(node_8387, _MainTex));
                float3 VertexColor = i.vertexColor.rgb;
                float3 emissive = ((_MainColor.rgb*_MainTex_var.rgb)*VertexColor);
                float node_1423 = (i.vertexColor.a*_Dissolution);
                float2 node_9748 = (i.uv0+(node_970.g*float2(_MaskUSpeed,_MaskVSpeed)));
                float4 _Mask_var = tex2D(_Mask,TRANSFORM_TEX(node_9748, _Mask));
                float node_5746_if_leA = step(node_1423,_Mask_var.r);
                float node_5746_if_leB = step(_Mask_var.r,node_1423);
                float node_3073 = 0.0;
                float node_6272 = 1.0;
                float node_5746 = lerp((node_5746_if_leA*node_3073)+(node_5746_if_leB*node_6272),node_6272,node_5746_if_leA*node_5746_if_leB);
                float node_5217_if_leA = step(node_1423,(_Mask_var.r+_OutLineRang));
                float node_5217_if_leB = step((_Mask_var.r+_OutLineRang),node_1423);
                float node_1274 = (node_5746-lerp((node_5217_if_leA*node_3073)+(node_5217_if_leB*node_6272),node_6272,node_5217_if_leA*node_5217_if_leB));
                float3 finalColor = emissive + ((node_1274*_OutLineColor.rgb));
                return fixed4(finalColor,(_MainColor.a*(_MainTex_var.a*(node_5746+node_1274))));
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
