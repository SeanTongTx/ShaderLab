Shader "Hidden/PointEmission"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_Postion("EmissionPostion",vector)=(0,0,0,1)
		[HDR]_EmissionColor("EmissionColor",color)=(1,1,1,1)
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
				float2 uv:TEXCOORD0;
				UNITY_FOG_COORDS(1)
				fixed4 lightColor : TEXCOORD2;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

			uniform float4 _Postion;
			uniform float4 _EmissionColor;

            v2f vert (appdata v)
            {
                v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);

				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				//模拟点光源

				half3 dir = (_Postion - v.vertex)/ _Postion.w;
				o.lightColor = (1-length(dir))*_EmissionColor;
				//
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
				fixed4 col = tex2D(_MainTex, i.uv)*i.lightColor;
                // sample the texture
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
