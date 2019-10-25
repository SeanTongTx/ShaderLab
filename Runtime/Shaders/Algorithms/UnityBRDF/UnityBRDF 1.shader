Shader "Unlit/UnityStandardBRDF1"
// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _MainTex("Albedo", 2D) = "white" {}

        _Cutoff("Alpha Cutoff", Range(0.0, 1.0)) = 0.5

        _Glossiness("Smoothness", Range(0.0, 1.0)) = 0.5
        _GlossMapScale("Smoothness Scale", Range(0.0, 1.0)) = 1.0
        [Enum(Metallic Alpha,0,Albedo Alpha,1)] _SmoothnessTextureChannel ("Smoothness texture channel", Float) = 0

        [Gamma] _Metallic("Metallic", Range(0.0, 1.0)) = 0.0
        _MetallicGlossMap("Metallic", 2D) = "white" {}

        [ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
        [ToggleOff] _GlossyReflections("Glossy Reflections", Float) = 1.0

        _BumpScale("Scale", Float) = 1.0
        [Normal] _BumpMap("Normal Map", 2D) = "bump" {}

        _Parallax ("Height Scale", Range (0.005, 0.08)) = 0.02
        _ParallaxMap ("Height Map", 2D) = "black" {}

        _OcclusionStrength("Strength", Range(0.0, 1.0)) = 1.0
        _OcclusionMap("Occlusion", 2D) = "white" {}

        _EmissionColor("Color", Color) = (0,0,0)
        _EmissionMap("Emission", 2D) = "white" {}

        _DetailMask("Detail Mask", 2D) = "white" {}

        _DetailAlbedoMap("Detail Albedo x2", 2D) = "grey" {}
        _DetailNormalMapScale("Scale", Float) = 1.0
        [Normal] _DetailNormalMap("Normal Map", 2D) = "bump" {}

        [Enum(UV0,0,UV1,1)] _UVSec ("UV Set for secondary textures", Float) = 0


        // Blending state
       _Mode ("__mode", Float) = 0.0
       _SrcBlend ("__src", Float) = 1.0
       _DstBlend ("__dst", Float) = 0.0
       _ZWrite ("__zw", Float) = 1.0
    }

    CGINCLUDE
        #define UNITY_SETUP_BRDF_INPUT MetallicSetup
    ENDCG

    SubShader
    {
        Tags { "RenderType"="Opaque" "PerformanceChecks"="False" }
        LOD 300


        // ------------------------------------------------------------------
        //  Base forward pass (directional light, emission, lightmaps, ...)
        Pass
        {
            Name "FORWARD"
            Tags { "LightMode" = "ForwardBase" }


            CGPROGRAM
            #pragma target 3.0

            // -------------------------------------

            #pragma shader_feature _NORMALMAP
            #pragma shader_feature_local _ _ALPHATEST_ON _ALPHABLEND_ON _ALPHAPREMULTIPLY_ON
            #pragma shader_feature _EMISSION
            #pragma shader_feature_local _METALLICGLOSSMAP
            #pragma shader_feature_local _DETAIL_MULX2
            #pragma shader_feature_local _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            #pragma shader_feature_local _SPECULARHIGHLIGHTS_OFF
            #pragma shader_feature_local _GLOSSYREFLECTIONS_OFF
            #pragma shader_feature_local _PARALLAXMAP

            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma multi_compile_instancing
            // Uncomment the following line to enable dithering LOD crossfade. Note: there are more in the file to uncomment for other passes.
            //#pragma multi_compile _ LOD_FADE_CROSSFADE

            #pragma vertex vertBase
            #pragma fragment fragBase
			#include "UnityCGINC\UnityStandardCore.cginc"
			inline half4 VertexGIForward1(VertexInput v, float3 posWorld, half3 normalWorld)
			{
				half4 ambientOrLightmapUV = 0;
				// Static lightmaps
				#ifdef LIGHTMAP_ON
					ambientOrLightmapUV.xy = v.uv1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					ambientOrLightmapUV.zw = 0;
				// Sample light probe for Dynamic objects only (no static or dynamic lightmaps)
				#elif UNITY_SHOULD_SAMPLE_SH
					#ifdef VERTEXLIGHT_ON
						// Approximated illumination from non-important point lights
						ambientOrLightmapUV.rgb = Shade4PointLights (
							unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
							unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
							unity_4LightAtten0, posWorld, normalWorld);
					#endif

					ambientOrLightmapUV.rgb = ShadeSHPerVertex (normalWorld, ambientOrLightmapUV.rgb);
				#endif

				#ifdef DYNAMICLIGHTMAP_ON
					ambientOrLightmapUV.zw = v.uv2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif

				return ambientOrLightmapUV;
			}
			VertexOutputForwardBase vertBase(VertexInput v)
			{
				UNITY_SETUP_INSTANCE_ID(v);
				VertexOutputForwardBase o;
				UNITY_INITIALIZE_OUTPUT(VertexOutputForwardBase, o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float4 posWorld = mul(unity_ObjectToWorld, v.vertex);
				#if UNITY_REQUIRE_FRAG_WORLDPOS
					#if UNITY_PACK_WORLDPOS_WITH_TANGENT
						o.tangentToWorldAndPackedData[0].w = posWorld.x;
						o.tangentToWorldAndPackedData[1].w = posWorld.y;
						o.tangentToWorldAndPackedData[2].w = posWorld.z;
					#else
						o.posWorld = posWorld.xyz;
					#endif
				#endif
				o.pos = UnityObjectToClipPos(v.vertex);

				o.tex = TexCoords(v);
				o.eyeVec.xyz = NormalizePerVertexNormal(posWorld.xyz - _WorldSpaceCameraPos);
				float3 normalWorld = UnityObjectToWorldNormal(v.normal);
				#ifdef _TANGENT_TO_WORLD
					float4 tangentWorld = float4(UnityObjectToWorldDir(v.tangent.xyz), v.tangent.w);

					float3x3 tangentToWorld = CreateTangentToWorldPerVertex(normalWorld, tangentWorld.xyz, tangentWorld.w);
					o.tangentToWorldAndPackedData[0].xyz = tangentToWorld[0];
					o.tangentToWorldAndPackedData[1].xyz = tangentToWorld[1];
					o.tangentToWorldAndPackedData[2].xyz = tangentToWorld[2];
				#else
					o.tangentToWorldAndPackedData[0].xyz = 0;
					o.tangentToWorldAndPackedData[1].xyz = 0;
					o.tangentToWorldAndPackedData[2].xyz = normalWorld;
				#endif

				//We need this for shadow receving
				UNITY_TRANSFER_LIGHTING(o, v.uv1);

				o.ambientOrLightmapUV = VertexGIForward1(v, posWorld, normalWorld);

				#ifdef _PARALLAXMAP
					TANGENT_SPACE_ROTATION;
					half3 viewDirForParallax = mul (rotation, ObjSpaceViewDir(v.vertex));
					o.tangentToWorldAndPackedData[0].w = viewDirForParallax.x;
					o.tangentToWorldAndPackedData[1].w = viewDirForParallax.y;
					o.tangentToWorldAndPackedData[2].w = viewDirForParallax.z;
				#endif

				UNITY_TRANSFER_FOG_COMBINED_WITH_EYE_VEC(o,o.pos);
				return o;
			}
			
			half4 fragBase(VertexOutputForwardBase i) : SV_Target
			{
				UNITY_APPLY_DITHER_CROSSFADE(i.pos.xy);

				FRAGMENT_SETUP(s)

				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);

				UnityLight mainLight = MainLight ();
				UNITY_LIGHT_ATTENUATION(atten, i, s.posWorld);

				//简单采样
				half occlusion = Occlusion(i.tex.xy);
				UnityGI gi = FragmentGI (s, occlusion, i.ambientOrLightmapUV, atten, mainLight);

				half4 c = UNITY_BRDF_PBS (s.diffColor, s.specColor, s.oneMinusReflectivity, s.smoothness, s.normalWorld, -s.eyeVec, gi.light, gi.indirect);
				c.rgb += Emission(i.tex.xy);


				Unity_GlossyEnvironmentData g = UnityGlossyEnvironmentSetup(s.smoothness, -s.eyeVec, s.normalWorld, s.specColor);



				UNITY_EXTRACT_FOG_FROM_EYE_VEC(i);
				UNITY_APPLY_FOG(_unity_fogCoord, c.rgb);
				return SmoothnessToPerceptualRoughness(s.smoothness); half4(g.reflUVW, 1);// half4(gi.indirect.specular, 1);
				// OutputForward(c, s.alpha);
			}

            ENDCG
        } 

    }

   //CustomEditor "StandardShaderGUI"
}
