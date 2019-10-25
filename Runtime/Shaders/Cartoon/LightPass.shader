
Shader "Hidden/ToonShader/LightPass"
{

	CGINCLUDE
		
            #include "UnityCG.cginc"

            #include "AutoLight.cginc"

            #include "Lighting.cginc"
			#include "../Cgincs/MaterialFX.cginc"
			#include "../Cgincs/MRTSupport.cginc"
			#pragma multi_compile _ _MODE_DITHER SOURCE_MRT

            struct VertexInput {

                float4 vertex : POSITION;

                float3 normal : NORMAL;

                float2 uv : TEXCOORD0;

            };

            struct VertexOutput {

                float4 pos : SV_POSITION;

                float4 posWorld : TEXCOORD0;

                float3 normalDir : TEXCOORD1;

                LIGHTING_COORDS(2,3)

                UNITY_FOG_COORDS(4)
				float4 ScreenPos : TEXCOORD5;

            };

			#if defined(_MODE_DITHER)
						CONTROLLER_BLOCK
			#endif
			uniform float _Gloss;
			uniform sampler2D _Ramp;
			uniform float4 _MainTex_ST;

            VertexOutput vert (VertexInput v) {

                VertexOutput o = (VertexOutput)0;

                o.normalDir = UnityObjectToWorldNormal(v.normal);

                o.posWorld = mul(unity_ObjectToWorld, v.vertex);

                float3 lightColor = _LightColor0.rgb;

                o.pos = UnityObjectToClipPos(v.vertex );

                UNITY_TRANSFER_FOG(o,o.pos);

                TRANSFER_VERTEX_TO_FRAGMENT(o)

				o.ScreenPos = ComputeScreenPos(o.pos);
                return o;

            }
	ENDCG
	SubShader
	{
		Tags { "RenderType"="Opaque"}
		Pass {

            Name "Add_HDR"

            Tags {

                "LightMode"="ForwardAdd"
            }

            Blend One One


            CGPROGRAM

            #pragma vertex vert

            #pragma fragment frag


            #pragma multi_compile_fwdadd_fullshadows

            #pragma multi_compile_fog
            #pragma target 3.0
		
			FRAG_OUT_TYPE frag(VertexOutput i) : COLOR
			{
				#if defined(_MODE_DITHER)
					float dither = Dither(i.ScreenPos);
					dither = _Control * 2 - dither;
					clip(dither - 0.5);
				#endif

                i.normalDir = normalize(i.normalDir);

                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);

                float3 normalDirection = i.normalDir;

                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));

                float3 lightColor = _LightColor0.rgb;

                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:

                float attenuation = LIGHT_ATTENUATION(i);

				float nhl = dot(normalDirection, halfDirection);
				nhl = smoothstep(0.3, 0.7, nhl);
				float nl = dot(lightDirection, normalDirection);

				//nl = smoothstep(0.5, 0.7, nl);

				fixed nlP = max(0.01, nl); // Lambert

				float4 ramp =  tex2D(_Ramp, half2(nlP, 0));

				nlP = ramp.r;

                float3 finalColor = (nlP+nlP*pow(max(0, nhl),exp2(lerp(1,11,_Gloss))))*_LightColor0.rgb*attenuation;


                fixed4 finalRGBA = fixed4(finalColor ,0);

                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
				//MRT/Core
					FRAG_OUT_TYPE o;
				SETUP_COLOR(o, finalRGBA);
				//MRT/HDR
				SETUP_COLORHDR(o, finalRGBA);
				return o;

            }

            ENDCG

        }
		Pass {

            Name "Add_LDR"

            Tags {

                "LightMode"="ForwardAdd"
            }

            Blend One One


            CGPROGRAM

            #pragma vertex vert

            #pragma fragment frag



            #pragma multi_compile_fwdadd_fullshadows

            #pragma multi_compile_fog
            #pragma target 3.0
				
            
			FRAG_OUT_TYPE frag(VertexOutput i) : COLOR
			{
				#if defined(_MODE_DITHER)
					float dither = Dither(i.ScreenPos);
					dither = _Control * 2 - dither;
					clip(dither - 0.5);
				#endif

                i.normalDir = normalize(i.normalDir);

                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);

                float3 normalDirection = i.normalDir;

                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));

                float3 lightColor = _LightColor0.rgb;

                float3 halfDirection = normalize(viewDirection+lightDirection);

////// Lighting:

                float attenuation = LIGHT_ATTENUATION(i);

				float nhl = dot(normalDirection, halfDirection);
				nhl = smoothstep(0.3, 0.7, nhl);
				float nl = dot(lightDirection, normalDirection);

				//nl = smoothstep(0.5, 0.7, nl);

				fixed nlP = max(0.01, nl); // Lambert

				float4 ramp =  tex2D(_Ramp, half2(nlP, 0));

				nlP = ramp.r;

                float3 finalColor = nlP*_LightColor0.rgb*attenuation;

                fixed4 finalRGBA = fixed4(finalColor,0);

                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
//MRT/Core
				FRAG_OUT_TYPE o;
				SETUP_COLOR(o, finalRGBA);
				//MRT/HDR
				SETUP_COLORHDR(o, finalRGBA);
				return o;
            }

            ENDCG

        }
		/*Passes*/
	}
	/*SubShader*/

}
