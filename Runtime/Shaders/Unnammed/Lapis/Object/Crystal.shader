Shader "Lapis/Object/Crystal"
{
    Properties
    {
		_Color("Color",color) = (1,1,1,1)
		_MainTex("MainTex", 2D) = "white" {}
		[NoScaleOffset]_CubeMap("CubeMap",CUBE) = ""{}
		_Smooth("Smooth",range(0,1)) = 0.5
		[HDR]_EmissionColor("EmissionColor",color) = (1,1,1,1)
		//r 反射分布图 g内部高度 b 自发光分布 a
		[NoScaleOffset]_HeightTex("Height", 2D) = "white" {}
		_Parallax("Height", Range(0.005, 0.08)) = 0.02
    }

    SubShader//LOD 600
	{
		Tags { "RenderType" = "Opaque" }
		LOD 600

		Pass
		{
			Name "BASE"
			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fog
			#pragma multi_compile __ SOURCE_MRT
			#include "Cgincs/Crystal600.cginc"
			ENDCG
		}
	}

	SubShader//LOD 500
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 500
		
		Pass
		{
			Name "BASE"
			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fog
			#pragma multi_compile __ SOURCE_MRT
			#include "Cgincs/Crystal500.cginc"
			ENDCG
		}
	}

	SubShader//LOD 400
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 400
		
		Pass
		{
			Name "BASE"
			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fog
			#pragma multi_compile __ SOURCE_MRT
			#include "Cgincs/Crystal400.cginc"
			ENDCG
		}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 100

		Pass
		{
			Name "BASE"
			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fog
			#pragma multi_compile __ SOURCE_MRT
			#include "Cgincs/Crystal100.cginc"
			ENDCG
		}
	}
}
