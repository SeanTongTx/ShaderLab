Shader "Lapis/Cloth/Gauze"
{	
	Properties
	{
		_MainTex("MainTex",2D) = ""{}
		_RampTex("Ramp",2D) = ""{}
		[NoScaleOffset]_ShadeTex("Shadow",2D) = ""{}
		_Alpha("Alpha",Range(0,1)) = 0
		[Enum(Strong,20,Normal,12,Weak,6)] _RimPower("Rim Power", float) = 12

		_Gloss("Gloss",Range(0,1)) = 0.5			
        _Mask("Mask", 2D) = "white" {}
		//材质特效
        [KeywordEnum(none,Dither,Dissolve)] _Mode("Mode", Float) = 0
        _Control("Control", range(0,1)) = 1
        //x世界空间y坐标，y 整体高度，z HDR z HDR range
        _Dissolve_Pramas("Dissolve_Pramas",vector)=(0,1.5,2,0.1)
	}

  //  SubShader//LOD 500
  //  {
		//Tags { "RenderType" = "Transparent" "Queue" = "Transparent"  }
		//LOD 500

		//Pass//Gauze back
		//{
		//	Name "GAUZE BACK"
		//	Tags { "LightMode" = "ForwardBase"  }

		//	Blend  SrcAlpha OneMinusSrcAlpha,Zero OneMinusSrcAlpha
		//	ZWrite Off
		//	Cull Front

		//	CGPROGRAM
		//	#pragma target 3.0
		//	#pragma vertex vert
		//	#pragma fragment frag
		//	#pragma multi_compile __ MODE_DITHER MODE_DISSOLVE SOURCE_MRT
		//	#define BACKPASS
		//	#include "../Object/Cgincs/Gauze500.cginc"
		//	ENDCG
		//}

		//Pass//Gauze front
		//{
		//	Name "GAUZE FRONT"
		//	Tags { "LightMode" = "ForwardBase"  }

		//	Blend  SrcAlpha OneMinusSrcAlpha,Zero OneMinusSrcAlpha
		//	ZWrite On
		//	Cull Back

		//	CGPROGRAM
		//	#pragma target 3.0
		//	#pragma vertex vert
		//	#pragma fragment frag
		//	#pragma multi_compile __ MODE_DITHER MODE_DISSOLVE SOURCE_MRT
		//	#define FRONTPASS
		//	#include "../Object/Cgincs/Gauze500.cginc"
		//	ENDCG
		//}

		//Pass//Add
		//{
		//	Name "ADD_LDR"
		//	Tags { "LightMode" = "ForwardAdd" }

		//	Blend One One

		//	CGPROGRAM
		//	#pragma target 3.0
		//	#pragma vertex vert
		//	#pragma fragment frag
		//	#pragma multi_compile __ MODE_DITHER SOURCE_MRT
		//	#pragma multi_compile_fwdadd_fullshadows
		//	#pragma multi_compile_fog
		//	#include "../../Cgincs/LightPass.cginc"
		//	ENDCG
		//}

		//Pass//Shadow
		//{
		//	Name "ShadowCaster"
		//	Tags { "LightMode" = "ShadowCaster" }

		//	ZWrite On ZTest LEqual Cull Off

		//	CGPROGRAM
		//	#pragma target 3.0
		//	#pragma vertex vert
		//	#pragma fragment frag
		//	#pragma multi_compile_shadowcaster
		//	#include "../../Cgincs/ShadowPass.cginc"
		//	ENDCG
		//}
  //  }
			
    SubShader//LOD 400
    {
		Tags { "RenderType" = "Transparent" "Queue" = "Transparent"  }
		LOD 400

		Pass//Gauze back
		{
			Name "GAUZE BACK"
			Tags { "LightMode" = "ForwardBase"  }

			Blend  SrcAlpha OneMinusSrcAlpha,Zero OneMinusSrcAlpha
			ZWrite Off
			Cull Front

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile __ MODE_DITHER MODE_DISSOLVE SOURCE_MRT
			#define BACKPASS
			#include "../Object/Cgincs/Gauze400.cginc"
			ENDCG
		}

		Pass//Gauze front
		{
			Name "GAUZE FRONT"
			Tags { "LightMode" = "ForwardBase"  }

			Blend  SrcAlpha OneMinusSrcAlpha,Zero OneMinusSrcAlpha
			ZWrite On
			Cull Back

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile __ MODE_DITHER MODE_DISSOLVE SOURCE_MRT
			#define FRONTPASS
			#include "../Object/Cgincs/Gauze400.cginc"
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
		Tags { "RenderType" = "Transparent" "Queue" = "Transparent"  }
		LOD 300
		UsePass "Hidden/Object/Gauze/Gauze_300"

		Pass//Gauze
		{
			Name "GAUZE FRONT"
			Tags { "LightMode" = "ForwardBase"  }

			Blend  SrcAlpha OneMinusSrcAlpha,Zero OneMinusSrcAlpha
			ZWrite On
			Cull Off

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile __ MODE_DITHER MODE_DISSOLVE SOURCE_MRT
			#define FRONTPASS
			#include "../Object/Cgincs/Gauze300.cginc"
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
		Tags { "RenderType" = "Transparent" "Queue" = "Transparent"  }
		LOD 250

		Pass//Gauze
		{
			Name "GAUZE FRONT"
			Tags { "LightMode" = "ForwardBase"  }
			
			Blend  SrcAlpha OneMinusSrcAlpha,Zero OneMinusSrcAlpha
			ZWrite On
			Cull Off

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile __ MODE_DITHER MODE_DISSOLVE SOURCE_MRT
			#define FRONTPASS
			#include "../Object/Cgincs/Gauze300.cginc"
			ENDCG
		}
    }

    SubShader//LOD 200
    {
		Tags { "RenderType" = "Transparent" "Queue" = "Transparent"  }
		LOD 200

		Pass//Gauze
		{
			Name "GAUZE FRONT"
			Tags { "LightMode" = "ForwardBase"  }

			Blend  SrcAlpha OneMinusSrcAlpha,Zero OneMinusSrcAlpha
			ZWrite On
			Cull Off

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile __ MODE_DITHER MODE_DISSOLVE SOURCE_MRT
			#define FRONTPASS
			#include "../Object/Cgincs/Gauze200.cginc"
			ENDCG
		}
    }

    SubShader//LOD 100
    {
		Tags { "RenderType" = "Opaque" }
		LOD 100

		Pass//Gauze
		{
			Name "GAUZE FRONT"
			Tags { "LightMode" = "ForwardBase"  }

			Blend  SrcAlpha OneMinusSrcAlpha,Zero OneMinusSrcAlpha
			ZWrite On
			Cull Off

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile __ MODE_DITHER MODE_DISSOLVE SOURCE_MRT
			#define FRONTPASS
			#include "../Object/Cgincs/Gauze100.cginc"
			ENDCG
		}
    }
}
