Shader "ShaderLab/Lapis/Character/Brow"
{

	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		[NoScaleOffset] _Ramp("Ramp", 2D) = "white" {}
		_Mask("Mask", 2D) = "white" {}
		[KeywordEnum(none,Dither,Dissolve)] _Mode("Mode", Float) = 0
		_Control("Control", range(0,1)) = 1
		//x世界空间y坐标，y 整体高度，z HDR z HDR range
		_Dissolve_Pramas("Dissolve_Pramas",vector) = (0,1.5,2,0.1)
	}

	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 300
		UsePass "Hidden/ShaderLab/Lapis/CharacterPass/Brow"
		UsePass "Hidden/ToonShader/ShadowPass/ShadowCaster"
	}
	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 200
		UsePass "Hidden/ShaderLab/Lapis/CharacterPass/Brow"
	}
	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		UsePass "Hidden/ShaderLab/Lapis/CharacterPass100/Brow_LOD100"
	}
}