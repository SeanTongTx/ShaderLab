Shader "Hidden/CubeMapReflect"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_CubeMap("CubeMap",CUBE) = ""{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

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
                float2 uv : TEXCOORD0;
				fixed3 normal : NORMAL;
            };

            struct v2f
            {
				float4 vertex : SV_POSITION;
                float3 worldNormal : NORMAL;
                float3 worldRef : TEXCOORD0;
                float3 worldPos : TEXCOORD1;
                float3 worldViewDir : TEXCOORD2;
				UNITY_FOG_COORDS(3)
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

			samplerCUBE _CubeMap;
			float4 _CubeMap_HDR;

            v2f vert (appdata v)
            {
                v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);

				o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.worldViewDir =  normalize(UnityWorldSpaceViewDir(o.worldPos.xyz));
                o.worldRef = reflect(-o.worldViewDir,normalize(o.worldNormal));

                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
				
                // sample the texture
				fixed4 col = 1;
				col.rgb= DecodeHDR(texCUBE(_CubeMap, i.worldRef), _CubeMap_HDR);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
