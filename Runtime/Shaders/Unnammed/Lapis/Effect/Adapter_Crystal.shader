Shader "ShaderLab/Sean/Object/Adapter_Crystal"
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
    SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 600
		UsePass "Hidden/ShaderLab/Object/Crystal/Crystal_Uber"
	} 
	SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 500
		UsePass "Hidden/ShaderLab/Object/Crystal/Crystal_500"
	}
	SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 400
		UsePass "Hidden/ShaderLab/Object/Crystal/Crystal_400"
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		UsePass "Hidden/ShaderLab/Object/Crystal/Crystal_fallBack"
	}
}
