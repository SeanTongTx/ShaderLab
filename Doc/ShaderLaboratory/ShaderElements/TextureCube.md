# TextureCube 
Cube纹理
## 关键字 
1·贴图名 Shader中使用的名字。
2·片段中输出颜色
即 采样后的颜色。
3·默认值。3种unity内置贴图
4·lod采样。切换为lod采样后，需要自己在代码中控制lod值
5·/*FRAGMENT_UVW*/采样所用的uv。一般使用half3 3维坐标。
常见于反射图的采样上。
### 关于Lod
在开启lod采样后，需要注意额外加入mipmaplevel。
参看文章
>>Article/CG/MipMap的LOD实现原理

### 关于UNITY_SAMPLE_TEXCUBE 宏定义

UNITY_SAMPLE_TEXCUBE(贴图名,3位坐标)
UNITY_SAMPLE_TEXCUBE_LOD(贴图名,4位坐标)

基于标准化需求，遵守Unity内置宏方法。
参考
>>Article/UnityBuiltIn/HLSLSupport

### 环境反射

CubeMap大部分都是拿来做环境反射的实现。
参看文献 
>>Article/UnityBuiltIn/Unity中的环境反射