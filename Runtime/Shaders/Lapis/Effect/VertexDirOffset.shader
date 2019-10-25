Shader "ShaderLab/Lapis/Effect/VertexDirOffset"
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
		}
		LOD 100
		Blend SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
		Cull Off Lighting Off ZWrite Off

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR0;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float3 _Value;

			v2f vert (appdata v)
			{
				v2f o;
				float3 dir = 2 * (v.color.xyz - 0.5);
				v.vertex.xyz = v.vertex.xyz + v.vertex.xyz * abs(dir) * _Value.x + dir * _Value.y;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
				col.a = col.a * clamp(_Value.z, 0, 1);
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
		}
	}
}
