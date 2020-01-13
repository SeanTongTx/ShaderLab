Shader "Lapis/Character/Body"
{
    Properties
    {
        _MainTex("Main Texture", 2D) = "white" {}
        [NoScaleOffset] _RampTex("Ramp Texture", 2D) = "white" {}
        [NoScaleOffset] _ShadeTex("Shade Texture", 2D) = "white" {}
		_LightRadiance("Light Radiance", Range(0.0, 1.0)) = 1.0
		_RimParam("Rim Param(x:bias,y:scale,z:power,w:strength)", Vector) = (-1, 10, 5, 1)

        _Mask("Mask", 2D) = "white" {}
        _Outline("Outline", float) = 1.2
        _OutlineInside("OutlineInside", float) = 0.02
        _OutlineColor("OutlineColor", Color) = (0,0,0,0)
        _Gloss("Gloss",range(0,1)) = 0.5
			
        [KeywordEnum(none,Dither,Dissolve)] Mode("Mode", Float) = 0
        _Control("Control", range(0,1)) = 1
        _Dissolve_Pramas("Dissolve_Pramas",vector)=(0,1.5,2,0.1)
    }

    SubShader//LOD400
    {
	   Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }
        LOD 400

		Pass//Base
		{
			Name "BASE"
			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile __ MODE_DITHER MODE_DISSOLVE SOURCE_MRT USE_FIXED_VIEW_LIGHTDIR
			#define OUTLINE_INSIDE
			#include "Cgincs/Skin.cginc"
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

    SubShader//LOD300
    {
		Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }
        LOD 300

		Pass//Base
		{
			Name "BASE"
			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile __ MODE_DITHER MODE_DISSOLVE SOURCE_MRT USE_FIXED_VIEW_LIGHTDIR
			#include "Cgincs/Skin.cginc"
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

    SubShader//LOD250
    {
		Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }
        LOD 250

		Pass//Base
		{
			Name "BASE"
			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile __ MODE_DITHER MODE_DISSOLVE SOURCE_MRT USE_FIXED_VIEW_LIGHTDIR
			#include "Cgincs/Skin.cginc"
			ENDCG
		}
    }

    SubShader//LOD200
    {
		Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }
		LOD 200

		Pass//Base
		{
			Name "BASE"
			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile __ SOURCE_MRT USE_FIXED_VIEW_LIGHTDIR
			#include "Cgincs/Skin200.cginc"
			ENDCG
		}
    }

    SubShader//LOD100
    {
		Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }
		LOD 100

		Pass//Base
		{
			Name "BASE"
			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile __ SOURCE_MRT
			#include "Cgincs/Skin100.cginc"
			ENDCG
		}
    }
}
