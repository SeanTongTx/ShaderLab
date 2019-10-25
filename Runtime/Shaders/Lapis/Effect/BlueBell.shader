
Shader "ShaderLab/Lapis/Effect/BlueBell" {
    Properties {
        [HDR]_Color ("Color", Color) = (0.5,0.5,0.5,1)
        _Texture ("Texture", 2D) = "white" {}
        [HDR]_Color_copy ("Color_copy", Color) = (0.5,0.5,0.5,1)
        _Texture_copy ("Texture_copy", 2D) = "white" {}
        [HDR]_Color_copy_copy ("Color_copy_copy", Color) = (0.5,0.5,0.5,1)
        _Texture_copy_copy ("Texture_copy_copy", 2D) = "white" {}
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Blend SrcAlpha OneMinusSrcAlpha
            //ZWrite Off
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
            uniform float4 _Color_copy;
            uniform sampler2D _Texture_copy; uniform float4 _Texture_copy_ST;
            uniform float4 _Color_copy_copy;
            uniform sampler2D _Texture_copy_copy; uniform float4 _Texture_copy_copy_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
				float2 uv1 : TEXCOORD1;
				float2 uv2 : TEXCOORD2;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.vertexColor = v.vertexColor;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv0 = TRANSFORM_TEX(v.texcoord0, _Texture);
				o.uv1 = TRANSFORM_TEX(v.texcoord0, _Texture_copy);
				o.uv2 = TRANSFORM_TEX(v.texcoord0, _Texture_copy_copy);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float4 _Texture_var = tex2D(_Texture,i.uv0);
                float4 _Texture_copy_var = tex2D(_Texture_copy, i.uv1);
                float4 _Texture_copy_copy_var = tex2D(_Texture_copy_copy, i.uv2);
                float3 emissive = (((_Color.rgb*_Texture_var.rgb)+(_Color_copy.rgb*_Texture_copy_var.rgb)+(_Color_copy_copy.rgb*_Texture_copy_copy_var.rgb))*i.vertexColor.rgb);
                float3 finalColor = emissive;
				return  fixed4(finalColor, (((_Color.a*_Texture_var.a) + (_Color_copy.a*_Texture_copy_var.a) + (_Color_copy_copy.b*_Texture_copy_copy_var.a))*i.vertexColor.a));
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
