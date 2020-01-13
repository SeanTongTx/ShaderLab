Shader "Lapis/Effect/VertexDirOffset"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Value("Value", Vector) = (1,0,1,0)
	}
	SubShader
	{
		Tags 
		{ 
			"Queue" = "Transparent" 
			"IgnoreProjector" = "True"
			"RenderType"="Transparent"
			"DisableBatching"="True"
		}
		LOD 100
		Blend SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
		Cull Off Lighting Off ZWrite Off

		Pass
		{
			Tags{ "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			#pragma multi_compile_instancing

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR0;
				float2 uv : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			UNITY_INSTANCING_BUFFER_START(Props)
			UNITY_DEFINE_INSTANCED_PROP(float4, _Value)
			UNITY_INSTANCING_BUFFER_END(Props)

			sampler2D _MainTex;
			float4 _MainTex_ST;

			v2f vert (appdata v)
			{
				v2f o;

				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float3 dir = 2 * (v.color.xyz - 0.5);
				v.vertex.xyz = v.vertex.xyz + v.vertex.xyz * abs(dir) * UNITY_ACCESS_INSTANCED_PROP(Props, _Value).x + dir * UNITY_ACCESS_INSTANCED_PROP(Props, _Value).y;
				o.vertex = UnityObjectToClipPos(v.vertex);

				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);

				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);

				col.a = col.a * saturate(UNITY_ACCESS_INSTANCED_PROP(Props, _Value).z);
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);

				return col;
			}
			ENDCG
		}
	}
}
