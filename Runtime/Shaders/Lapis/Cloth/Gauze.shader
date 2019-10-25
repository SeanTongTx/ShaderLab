Shader "ShaderLab/Lapis/Cloth/Gauze"
{	
	Properties
	{
		_MainTex("MainTex",2D) = ""{}
		_Ramp("Ramp",2D) = ""{}
		[NoScaleOffset]_ShadowTex("Shadow",2D) = ""{}
		_Alpha("Alpha",Range(0,1)) = 0
		[Enum(Strong,20,Normal,12,Weak,6)] _RimPower("Rim Power", float) = 12

		_OutlineInside("OutlineInside",float) = 1.2
		_OutlineColor("OutlineColor", Color) = (0,0,0,0)
		_Gloss("Gloss",Range(0,1)) = 0.5
		/*Properties*/
			
        _Mask("Mask", 2D) = "white" {}
		//材质特效
        [KeywordEnum(none,Dither,Dissolve)] _Mode("Mode", Float) = 0
        _Control("Control", range(0,1)) = 1
        //x世界空间y坐标，y 整体高度，z HDR z HDR range
        _Dissolve_Pramas("Dissolve_Pramas",vector)=(0,1.5,2,0.1)
	}
    SubShader
    {
		Tags { "RenderType" = "Transparent" "Queue" = "Transparent"  }
		LOD 500
		UsePass "Hidden/ShaderLab/Object/Gauze/Gauze_back"
		UsePass "Hidden/ShaderLab/Object/Gauze/Gauze_front"
		UsePass "Hidden/ToonShader/LightPass/Add_LDR"
		UsePass "Hidden/ToonShader/ShadowPass/ShadowCaster"
    }
			
    SubShader
    {
		Tags { "RenderType" = "Transparent" "Queue" = "Transparent"  }
		LOD 400
		UsePass "Hidden/ShaderLab/Object/Gauze/Gauze_back_400"
		UsePass "Hidden/ShaderLab/Object/Gauze/Gauze_front_400"
		UsePass "Hidden/ToonShader/LightPass/Add_LDR"
		UsePass "Hidden/ToonShader/ShadowPass/ShadowCaster"
    }
    SubShader
    {
		Tags { "RenderType" = "Transparent" "Queue" = "Transparent"  }
		LOD 300
		UsePass "Hidden/ShaderLab/Object/Gauze/Gauze_300"
		UsePass "Hidden/ToonShader/LightPass/Add_LDR"
		UsePass "Hidden/ToonShader/ShadowPass/ShadowCaster"
    }
    SubShader
    {
		Tags { "RenderType" = "Transparent" "Queue" = "Transparent"  }
		LOD 250
		UsePass "Hidden/ShaderLab/Object/Gauze/Gauze_300"
    }
    SubShader
    {
		Tags { "RenderType" = "Transparent" "Queue" = "Transparent"  }
		LOD 200
		UsePass "Hidden/ShaderLab/Object/Gauze/Gauze_200"
    }
    SubShader
    {
		Tags { "RenderType" = "Opaque" }
		UsePass "Hidden/ShaderLab/Object/Gauze/Gauze_100"
    }
}
