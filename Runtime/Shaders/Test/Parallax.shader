Shader "Hidden/Parallax"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_ParallaxMap("ParallaxMap", 2D) = "white" {}
		_Parallax("Height", Range(0.005, 0.08)) = 0.02

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
				float4 tangent:TANGENT;
            };

            struct v2f
            {
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float2 uv_P : TEXCOORD2;
				float3 view : TEXCOORD3;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
			sampler2D _ParallaxMap;
			float4 _ParallaxMap_ST;
			float _Parallax;

			samplerCUBE _CubeMap;

            v2f vert (appdata v)
            {
                v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uv_P= TRANSFORM_TEX(v.uv, _ParallaxMap);

				TANGENT_SPACE_ROTATION;

				o.view = mul(rotation, ObjSpaceViewDir(v.vertex).xyz);

                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
				fixed4 height = tex2D(_ParallaxMap, i.uv_P);

				float2 offset = ParallaxOffset(height.r, _Parallax, i.view);


				fixed4 rawCol = tex2D(_MainTex, i.uv+ offset);

                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, rawCol);
                return rawCol;
            }
            ENDCG
        }
    }
}
