Shader "ShaderLab/Sean/Object/Kaleido"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_MainTex2("Texture", 2D) = "white" {}
		_Speed("Speed", float) = 1
		_Center("Center", vector) = (0.5,0.5,0,0)
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
			#include "../../Cgincs/UVHelper.cginc"
            struct appdata
            {
                float4 vertex : POSITION;
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
			sampler2D _MainTex2;
			float4 _MainTex2_ST;
			half _Speed;
            half4 _Center;
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uv = RotUV(o.uv, _Time.x*_Speed, _Center.xy);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
				fixed4 col2 = tex2D(_MainTex2, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return lerp(col,col2,col2.a);
            }
            ENDCG
        }
    }
}
