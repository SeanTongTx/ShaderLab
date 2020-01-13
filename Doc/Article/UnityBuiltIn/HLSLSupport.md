# HLSLSupport 
大量Shader关键字 宏定义。
为了跨平台的着色器编译宏和定义提供支持。

下载Unity对应版本BuiltinShader 查看源代码。

### 标准化

尽可能的使用Unity定义的方式调用Shader。从而不用关心跨平台和各种问题的细节。

比如：CubeMap采样
``` 源码
#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))
    // DX11 style HLSL syntax; separate textures and samplers
    //....
    #define UNITY_SAMPLE_TEXCUBE(tex,coord) tex.Sample (sampler##tex,coord)
    #define UNITY_SAMPLE_TEXCUBE_LOD(tex,coord,lod) tex.SampleLevel (sampler##tex,coord, lod)
#else
    // DX9 style HLSL syntax; same object for texture+sampler
    ...
    #define UNITY_SAMPLE_TEXCUBE(tex,coord) texCUBE (tex,coord)
    #define UNITY_SAMPLE_TEXCUBE_LOD(tex,coord,lod) texCUBElod (tex, half4(coord, lod))
```
可见在不同的平台/API下指令是会有差异的 不过目前看来大部分是DX11和DX9的差异。




