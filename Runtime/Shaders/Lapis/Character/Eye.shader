Shader "ShaderLab/Lapis/Character/Eye"
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

	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 250
		UsePass "Hidden/ShaderLab/Lapis/CharacterPass/Eye"
		UsePass "Hidden/ToonShader/LightPass/Add_LDR"
		UsePass "Hidden/ToonShader/ShadowPass/ShadowCaster"
	}
	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		UsePass "Hidden/ShaderLab/Lapis/CharacterPass100/Eye_LOD100"
	}
}