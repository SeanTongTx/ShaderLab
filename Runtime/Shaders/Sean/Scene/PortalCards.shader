Shader "Hidden/PortalCards"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_fade("Fade",float)=0.32
		[Toggle(SPHERICAL)]FEATURE_SPHERICAL("Spherical", Int) = 1
		[Toggle(DEBUG)]FEATURE_DEBUG("Debug", Int) = 0
		_f1("f1",float) =3.2
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Transparent"  "DisableBatching" = "True" }
        LOD 100
		ZWrite off
		cull off
		blend srcalpha oneminussrcalpha
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#pragma multi_compile SOURCE_UNITY SOURCE_ZBUFFER SOURCE_MRT
			#pragma multi_compile_instancing
			#pragma shader_feature_local SPHERICAL
			#pragma shader_feature_local DEBUG
            #include "UnityCG.cginc"
			#include "../../Cgincs/SeanProcessSupport.cginc"
			#include "../../Cgincs/BillboardSupport.cginc"
			#define PI 3.14159265358979323846
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
				float3 normal:NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
				float4 screenPos:TEXCOORD1;
				float2 uvScale:TEXCOORD2;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
			uniform fixed _fade;
			uniform fixed _f1;
            v2f vert (appdata v)
            {
                v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
#if SPHERICAL
				v.vertex = VertexSpherical(v.vertex, v.normal);
#else
				v.vertex = VertexCylindrical(v.vertex, v.normal);
#endif

				//根据距离 缩放顶点
				float depthScale= saturate(COMPUTE_DEPTH_01*10);

				v.vertex.xyz *= depthScale;
				//v.vertex = vertexDepthScale(v.vertex);
				o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uvScale =(o.uv - half2(0.5, 0.5))*depthScale + half2(0.5, 0.5);
				o.screenPos = ComputeScreenPos(o.vertex);
                return o;
            }
            fixed4 frag (v2f i) : SV_Target
            {
				//屏幕深度
				fixed2 ScreenUV= i.screenPos /= i.screenPos.w;
				ScreenUV = i.screenPos.xy;
				float Screendepth =ScreenDepth(ScreenUV);
				//自身深度	
				float depth = Linear01Depth(i.vertex.z);

                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uvScale);
				float d = Screendepth - depth;
				//D
				float D= saturate(pow(10, pow(d, _fade))*(depth*5) - 1);
				//float D=saturate(pow(d, _fade));
				float2 f2 = min(abs(1 - i.uv),abs(i.uv))*_f1;
				D *=saturate(min(f2.x,f2.y));
#if DEBUG
				return D;
#else
				col.a*= D;
				return col;
#endif
            }
            ENDCG
        }
    }
}
