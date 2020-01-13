Shader "SHADER_NAME"
{
	Properties
	{
		/*SHADER_PROPERTIES*/
	}
		SubShader
	{
		/*SHADER_TAGS*/
		Pass
		{
			Tags {/*PASS_TAGS*/}
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			
			/*PASS_PRAGMAS*/

			struct appdata
			{
				float4 vertex : POSITION;
				/*APPDATA_PRAGMAS*/
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				/*V2F*/
			};

			/*PASS_PROPERTIES*/
			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);

				/*VERT_PROCESS*/
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				 
				return 1;
			}
			ENDCG
		}
	}
}
