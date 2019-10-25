
Shader "ShaderLab/Lapis/Effect/ColorHDR_Blend" {
    Properties {
        [HDR]_Texture_Color ("Texture_Color", Color) = (0.5,0.5,0.5,1)
        _Texture ("Texture", 2D) = "white" {}
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Blend SrcAlpha OneMinusSrcAlpha
            //ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma target 3.0
            uniform float4 _Texture_Color;
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
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
                o.uv0 = TRANSFORM_TEX(v.texcoord0, _Texture);
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR 
			{
////// Lighting:
////// Emissive:
                float4 _Texture_var = tex2D(_Texture,i.uv0);
                float3 emissive = (_Texture_var.rgb*_Texture_Color.rgb*i.vertexColor.rgb);
                float3 finalColor = emissive;
                return fixed4(finalColor,(_Texture_var.a*_Texture_Color.a*i.vertexColor.a));
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
