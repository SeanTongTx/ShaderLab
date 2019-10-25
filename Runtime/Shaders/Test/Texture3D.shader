Shader "Unlit/Texture3D"
{
    Properties
    {
		_Z("Z",range(0,1))=0.5

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue" = "Transparent" }
        LOD 100
		cull off 
		zwrite off
		Blend SrcAlpha OneMinusSrcAlpha
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog
			//开启gpu instancing
			#pragma multi_compile_instancing

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
				float4 posWorld : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
			float _Z;
			UNITY_INSTANCING_BUFFER_START(Props)
				UNITY_DEFINE_INSTANCED_PROP(float4, _NoiseLocal)
				UNITY_DEFINE_INSTANCED_PROP(float3, _NoiseParam)
			UNITY_INSTANCING_BUFFER_END(Props)
			uniform sampler3D _VLB_NoiseTex3D;
			uniform float4 _VLB_NoiseGlobal;
            v2f vert (appdata v, uint vid : SV_VertexID)
            {
				UNITY_SETUP_INSTANCE_ID(v);
                v2f o;
				UNITY_TRANSFER_INSTANCE_ID(v, o);

                o.vertex = UnityObjectToClipPos(v.vertex);
				//worldPos
				o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }
			float GetNoise3DFactor(float3 wpos)
			{
				float intensity = UNITY_ACCESS_INSTANCED_PROP(Props, _NoiseParam).x;
				float3 velocity = lerp(UNITY_ACCESS_INSTANCED_PROP(Props, _NoiseLocal).xyz, _VLB_NoiseGlobal.xyz, UNITY_ACCESS_INSTANCED_PROP(Props, _NoiseParam).y);
				float scale = lerp(UNITY_ACCESS_INSTANCED_PROP(Props, _NoiseLocal).w, _VLB_NoiseGlobal.w, UNITY_ACCESS_INSTANCED_PROP(Props, _NoiseParam).z);
				float noise = tex3D(_VLB_NoiseTex3D, frac(wpos * scale + (_Time.y * velocity))).a;
				return lerp(1, noise, intensity);
			}

            fixed4 frag (v2f i) : SV_Target
            {
				UNITY_SETUP_INSTANCE_ID(i);
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);

				col = tex3D(_VLB_NoiseTex3D, fixed3(i.uv, frac(_Z))).a;
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
