
Shader "ShaderLab/Lapis/Effect/Blade" {
    Properties {
        _Tex1 ("Tex1", 2D) = "white" {}
        _Tex2 ("Tex2", 2D) = "white" {}
        _Mut ("Mut", Float ) = 4
        _Color ("Color", Color) = (0.3345942,0.9716981,0.9542375,1)
        _Tex1XSpeed ("Tex1 XSpeed", Float ) = 0
        _Tex1YSpeed ("Tex1 YSpeed", Float ) = 0
        _Tex2XSpeed ("Tex2 XSpeed", Float ) = 0
        _Tex2YSpeed ("Tex2 YSpeed", Float ) = 0
        _Turb ("Turb", Float ) = 0
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
            #pragma target 3.0
            uniform sampler2D _Tex1; uniform float4 _Tex1_ST;
            uniform sampler2D _Tex2; uniform float4 _Tex2_ST;
            uniform float4 _Color;
            uniform float _Mut;
            uniform float _Tex1XSpeed;
            uniform float _Tex1YSpeed;
            uniform float _Tex2XSpeed;
            uniform float _Tex2YSpeed;
            uniform float _Turb;
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

				float4 node_62 = _Time;
				float2 node_1601 = (v.texcoord0 + (node_62.g*float2(_Tex2XSpeed, _Tex2YSpeed)));

				o.uv0 = TRANSFORM_TEX(node_1601, _Tex2);
				o.uv1 = TRANSFORM_TEX(float2(_Tex1XSpeed, _Tex1YSpeed)*node_62.g + v.texcoord0, _Tex1);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR 
			{
                float4 _Tex2_var = tex2D(_Tex2,i.uv0);
                float TurbSet = _Tex2_var.g;
                float2 node_9783 = (i.uv1 +(TurbSet*_Turb));

                float4 _Tex1_var = tex2D(_Tex1, node_9783);
                float3 finalColor = ((_Tex1_var.rgb*_Tex2_var.rgb*_Color.rgb*_Mut*i.vertexColor.a)*i.vertexColor.rgb);
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
