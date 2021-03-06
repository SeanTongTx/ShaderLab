﻿Shader "Hidden/DistanceCard"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_Distance("Distance",float)=10
    }
    SubShader
    {
		Tags{ "RenderType" = "Opaque" "Queue" = "Transparent" }
        LOD 100
		zwrite off
		Blend SrcAlpha OneMinusSrcAlpha

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
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
				float depth : TEXCOORD1;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				 COMPUTE_EYEDEPTH(o.depth);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }
			float _Distance;
			float _X;
            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv).r;
				col *=saturate(i.depth/_Distance);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
