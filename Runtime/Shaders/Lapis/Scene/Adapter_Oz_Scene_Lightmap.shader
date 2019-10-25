Shader "ShaderLab/Lapis/Scene/Adapter_OzSceneLightmap"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex ("Texture", 2D) = "white" {}
		[NoScaleOffset]_LightMap("Light Map", 2D) = "white" {}
		_LightMapParams("LightMapParams",vector)=(0.3,0.5,0.5,0)
	}
	SubShader
	{
		Tags{ "RenderType" = "Opaque" "ForceNoShadowCasting" = "True" "Queue" = "Geometry" }
		LOD 200
		UsePass "ShaderLab/Lapis/Scene/LightMapOpaque/LightMap_Opaque"
	}
	SubShader
	{
		Tags{ "RenderType" = "Opaque" "ForceNoShadowCasting" = "True" "Queue" = "Geometry" }
		UsePass "ShaderLab/Lapis/Scene/LightMapOpaque/LightMap_Opaque_LOD100"
	}
	Fallback "Mobile/VertexLit"
}
