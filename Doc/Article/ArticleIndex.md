# ShaderLab/Article

# 目录

## Algorithms

这里,主要统计和记录各种类型的算法并做简单实践。
考虑到算法终究是实现原理，更多的实现细节跟着引擎会有很多修改。
/{ ▶算法学专栏

PBR -基于物理的渲染原理
>Algorithms/PBR

PBCR -基于物理的卡通渲染(暂定)记录
>Algorithms/PBCR

UnityPBR -unity中的PBS实现
>Algorithms/UnityPBR

/}

## CG

计算机图形学相关的信息。
/{ ▶计算机图形学
>CG/CG标准函数库
>CG/MipMap的LOD实现原理
>CG/切线空间
>CG/法线贴图
/}

## UnityBuiltinShader

Unity的ShaderLab对Shader的使用做了大量的封装和定义。
对应的实现考虑到了需要不同的情况，因此出错的可能性比较小。
与此同时可能会额外处理很多完全不需要的东西，从而带来浪费。

考虑到标准化，推荐尽可能使用Unity已经实现的内置方法。

### 内置方法的分析

/{ ▶Unity内置分析

>UnityBuiltIn/ComputeScreenPos函数
>UnityBuiltIn/HLSLSupport
>UnityBuiltIn/Unity中使用Normal
>UnityBuiltIn/Unity中的环境反射
/}
