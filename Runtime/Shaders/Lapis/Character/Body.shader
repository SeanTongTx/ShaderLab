﻿Shader "ShaderLab/Lapis/Character/Body"
{
    Properties
    {
        _MainTex("MainTex", 2D) = "white" {}
        [NoScaleOffset] _Ramp("Ramp", 2D) = "white" {}
        [NoScaleOffset] _ShadowTex("Shadow", 2D) = "white" {}

        _Mask("Mask", 2D) = "white" {}
        _Outline("Outline",float) = 1.2
        _OutlineInside("OutlineInside",float) = 1.2
        _OutlineColor("OutlineColor", Color) = (0,0,0,0)
        _Gloss("Gloss",range(0,1)) = 0.5
			
        [KeywordEnum(none,Dither,Dissolve)] _Mode("Mode", Float) = 0
        _Control("Control", range(0,1)) = 1
        //x世界空间y坐标，y 整体高度，z HDR z HDR range
        _Dissolve_Pramas("Dissolve_Pramas",vector)=(0,1.5,2,0.1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 400
        UsePass "Hidden/ShaderLab/Lapis/CharacterPass/Skin"
		UsePass "Hidden/ToonShader/Outline/OUTLINE"
		UsePass "Hidden/ToonShader/LightPass/Add_LDR"
		UsePass "Hidden/ToonShader/ShadowPass/ShadowCaster"
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 300
        UsePass "Hidden/ShaderLab/Lapis/CharacterPass/Skin"
		UsePass "Hidden/ToonShader/LightPass/Add_LDR"
		UsePass "Hidden/ToonShader/ShadowPass/ShadowCaster"
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 250
        UsePass "Hidden/ShaderLab/Lapis/CharacterPass/Skin"
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
		LOD 200
        UsePass "Hidden/ShaderLab/Lapis/CharacterPass200/Skin_LOD200"
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        UsePass "Hidden/ShaderLab/Lapis/CharacterPass100/Skin_LOD100"
    }
}
