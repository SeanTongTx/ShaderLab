# Texture3D 
3D纹理
## 关键字 

1·贴图名 Shader中使用的名字。
2·片段中输出颜色
即 采样后的颜色。
3·默认值。3种unity内置贴图
4·lod采样。切换为lod采样后，需要自己在代码中控制lod值
5·/*FRAGMENT_UVW*/采样所用的uv。一般使用half3 3维坐标。
常见于采样深度雾。

在开启lod采样后，需要注意额外加入mipmaplevel。
参看文章
>>Article/CG/MipMap的LOD实现原理