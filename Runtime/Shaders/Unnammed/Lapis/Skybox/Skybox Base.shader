// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)

Shader "Lapis/Skybox/Skybox Base" 
{
	Properties 
	{
		_MainTex("Base (RGB)", 2D) = "white" {}
	}

	SubShader 
	{
		Tags { "Queue"="Geometry+100" "RenderType"="Background" "PreviewType"="Skybox" }
		Cull Off 

		Pass 
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 2.0

			#include "UnityCG.cginc"

			struct appdata_t 
			{
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f 
			{
				float4 vertex : SV_POSITION;
				float2 texcoord : TEXCOORD0;
			};

			sampler2D _MainTex;

			v2f vert(appdata_t v)
			{
				v2f o;

				o.vertex = UnityObjectToClipPos(v.vertex);
				o.texcoord = v.texcoord;

				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.texcoord);
				UNITY_OPAQUE_ALPHA(col.a);

				return col;
			}
			ENDCG
		}
	}
	Fallback Off
}
