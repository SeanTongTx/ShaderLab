
Shader "ShaderLab/Lapis/Effect/Dissolution_Add" {
    Properties {
        [HDR]_MainColor ("Main Color", Color) = (0.6985294,0.6985294,0.6985294,1)
        _MainTexture ("Main Texture", 2D) = "white" {}
        _Dissolution ("Dissolution", Range(0,1)) =0.5
        _MaskTexture ("Mask Texture", 2D) = "white" {}
        [HDR]_OutLineColor ("OutLine Color", Color) = (0.9716981,0.8256075,0.380429,1)
        _OutLineRang ("OutLine Rang", Range(0,1)) = 0.03
        _MainUSpeed ("Main USpeed", Float ) = 0
        _MainVSpeed ("Main VSpeed", Float ) = 0
        _MaskUSpeed ("Mask USpeed", Float ) = 0
        _MaskVSpeed ("Mask VSpeed", Float ) = 0
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Blend One One
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma target 3.0
            uniform sampler2D _MaskTexture; uniform float4 _MaskTexture_ST;
            uniform sampler2D _MainTexture; uniform float4 _MainTexture_ST;
            uniform float4 _MainColor;
            uniform float _Dissolution;
            uniform float _OutLineRang;
            uniform float4 _OutLineColor;
            uniform float _MainUSpeed;
            uniform float _MainVSpeed;
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
				float2 uv1 : TEXCOORD1;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
				o.uv1 = v.texcoord0;
				float t = _Time.y;
				o.uv0 = TRANSFORM_TEX(fixed2(_MainUSpeed, _MainVSpeed)*t + v.texcoord0, _MainTexture);
				o.uv1 = TRANSFORM_TEX(fixed2(_MaskUSpeed, _MaskVSpeed)*t+ v.texcoord0, _MaskTexture);

                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR 
			{
                float4 _MainTexture_var = tex2D(_MainTexture,i.uv0);
                float Dissolution = (i.vertexColor.a*_Dissolution);
                float4 _MaskTexture_var = tex2D(_MaskTexture,i.uv1);
                float node_5746_if_leA = step(Dissolution,_MaskTexture_var.r);
                float node_5746_if_leB = step(_MaskTexture_var.r,Dissolution);
                float node_5746 = lerp((node_5746_if_leB),1,node_5746_if_leA*node_5746_if_leB);
                float node_5217_if_leA = step(Dissolution,(_MaskTexture_var.r+_OutLineRang));
                float node_5217_if_leB = step((_MaskTexture_var.r+_OutLineRang),Dissolution);
                float node_1274 = saturate(node_5746-lerp(node_5217_if_leB,1,node_5217_if_leA*node_5217_if_leB));
                float node_6450 = saturate((node_5746+node_1274));
                float3 node_7666 = ((node_1274*_OutLineColor.rgb));
                float3 emissive = (_MainColor.a*(((_MainColor.rgb*_MainTexture_var.rgb*i.vertexColor.rgb)*node_6450+ node_7666))*(_MainColor.a*(_MainTexture_var.a*node_6450)));
                float3 finalColor = emissive + (_MainColor.a*node_7666);
                return half4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
