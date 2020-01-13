Shader "Lapis/Object/Metal"
{
	Properties
	{ 
		[NoScaleOffset]_MainTex("Main Texture (A is Mask)", 2D) = "white" {}
		[NoScaleOffset]_RampTex("Ramp Texture", 2D) = "white" {}
		[NoScaleOffset]_ShadeTex("Shade Texture",2D) = "white" {}
		_LightRadiance("Light Radiance", Range(0.0, 1.0)) = 1.0
		_RimParam("Rim Param(x:bias,y:scale,z:power,w:strength)", Vector) = (-1, 10, 5, 1)

		[NoScaleOffset]_ReflectTex("Reflect Texture", Cube) = "white" {}
		_Reflective("Reflective", Range(0, 1)) = 0.5

		[Toggle(ENABLE_ANISOTROPY)] FEATURE_ANISOTROPY("Enable Anisotropy", Float) = 1
		[NoScaleOffset]_AnisoTex("Aniso Texture", 2D) = "gray" {}
		_AnisoScale("Anisotropic Scale", float) = 1

		[Toggle(ENABLE_SPECULAR)] FEATURE_SPECULAR("Enable Specular", Float) = 1
		[NoScaleOffset]_SpecTex("Specular Texture (A is Specular Mask)", 2D) = "white" {}
		_Shininess("Shininess", Range(1, 32)) = 10
		_SpecMulti("SpecMulti", Range(0, 5)) = 2

	}

	SubShader//LOD 300
	{
		Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }
		LOD 300

		Pass//Base
		{
			Name "Base"
			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile __ SOURCE_MRT USE_FIXED_VIEW_LIGHTDIR
			#pragma shader_feature_local ENABLE_ANISOTROPY
			#pragma shader_feature_local ENABLE_SPECULAR
			#include "Cgincs/Metal.cginc"
			ENDCG
		}
	}
}