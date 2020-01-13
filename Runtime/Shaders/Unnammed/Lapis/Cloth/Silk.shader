Shader "Lapis/Cloth/Silk"
{
	Properties
	{ 
		[NoScaleOffset]_MainTex("Main Texture", 2D) = "white" {}
		[NoScaleOffset]_RampTex("Ramp Texture",2D) = "white" {}
		[NoScaleOffset]_ShadeTex("Shade Texture",2D) = "white" {}
		_LightRadiance("Light Radiance", Range(0.0, 1.0)) = 1.0
		_RimParam("Rim Param(x:bias,y:scale,z:power,w:strength)", Vector) = (-1, 10, 5, 1)

		_Outline("Outline",float) = 1.2
		_OutlineInside("OutlineInside", float) = 0.02
		_OutlineColor("Outline Color", Color) = (0,0,0,0)

		[Toggle(ENABLE_SHIFT)]FEATURE_SHIFT("Enable Shift", Float) = 1
		[NoScaleOffset]_ShiftTex("Shift Texture", 2D) = "balck" {}
		_Shift("Shift", Vector) = (0, 1, 0 ,1)

		[NoScaleOffset]_SpecTex("Specular Texture",2D) = "white" {}
		_Shininess("Shininess", Range(1, 128)) = 10
		_SpecMulti("SpecMulti", Range(0, 1)) = 0.5
	}

	SubShader//LOD 400
	{
		Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }
		LOD 400

		Pass//Base
		{
			Name "Base"
			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile __ SOURCE_MRT USE_FIXED_VIEW_LIGHTDIR
			#pragma shader_feature_local ENABLE_SHIFT
			#define OUTLINE_INSIDE
			#include "../Object/Cgincs/Silk.cginc"
			ENDCG
		}

		Pass//Outline
		{
			Name "OUTLINE"
			Tags { "LightMode" = "ForwardBase" }

			Cull Front

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile __ MODE_DITHER MODE_DISSOLVE
			#include "../../Cgincs/Outline.cginc"
			ENDCG
		}

		Pass//Add
		{
			Name "ADD_LDR"
			Tags { "LightMode" = "ForwardAdd" }

			Blend One One

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile __ MODE_DITHER SOURCE_MRT
			#pragma multi_compile_fwdadd_fullshadows
			#pragma multi_compile_fog
			#include "../../Cgincs/LightPass.cginc"
			ENDCG
		}

		Pass//Shadow
		{
			Name "ShadowCaster"
			Tags { "LightMode" = "ShadowCaster" }

			ZWrite On ZTest LEqual Cull Off

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_shadowcaster
			#include "../../Cgincs/ShadowPass.cginc"
			ENDCG
		}
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
			#pragma shader_feature_local ENABLE_SHIFT
			#include "../Object/Cgincs/Silk.cginc"
			ENDCG
		}

		Pass//Add
		{
			Name "ADD_LDR"
			Tags { "LightMode" = "ForwardAdd" }

			Blend One One

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile __ MODE_DITHER SOURCE_MRT
			#pragma multi_compile_fwdadd_fullshadows
			#pragma multi_compile_fog
			#include "../../Cgincs/LightPass.cginc"
			ENDCG
		}

		Pass//Shadow
		{
			Name "ShadowCaster"
			Tags { "LightMode" = "ShadowCaster" }

			ZWrite On ZTest LEqual Cull Off

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_shadowcaster
			#include "../../Cgincs/ShadowPass.cginc"
			ENDCG
		}
	}

	SubShader//LOD 250
	{
		Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }
		LOD 250

		Pass//Base
		{
			Name "Base"
			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile __ SOURCE_MRT USE_FIXED_VIEW_LIGHTDIR
			#pragma shader_feature_local ENABLE_SHIFT
			#include "../Object/Cgincs/Silk.cginc"
			ENDCG
		}
	}

	SubShader//LOD 200
	{
		Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }
		LOD 200

		Pass//Base
		{
			Name "Base"
			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#include "../Character/Cgincs/Skin200.cginc"
			ENDCG
		}
	}

	SubShader//LOD 100
	{
		Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }
		LOD 100

		Pass//Base
		{
			Name "Base"
			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#include "../Character/Cgincs/Skin100.cginc"
			ENDCG
		}
	}
}