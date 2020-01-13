Shader "Lapis/Character/Brow"
{

	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_Mask("Mask", 2D) = "white" {}
		[KeywordEnum(none,Dither,Dissolve)] _Mode("Mode", Float) = 0
		_Control("Control", range(0,1)) = 1
		//x世界空间y坐标，y 整体高度，z HDR z HDR range
		_Dissolve_Pramas("Dissolve_Pramas",vector) = (0,1.5,2,0.1)
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
			#pragma multi_compile __ MODE_DITHER MODE_DISSOLVE SOURCE_MRT
			#include "Cgincs/Brow.cginc"
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
			#pragma multi_compile __ MODE_DITHER MODE_DISSOLVE SOURCE_MRT
			#include "Cgincs/Brow.cginc"
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
			#include "Cgincs/Brow100.cginc"
			ENDCG
		}
	}
}