# ReflectCube 
CubeMap反射计算

## 关键字
1·/*WORLD_REFLECT*/ 世界空间反射。3维向量用于TextureCube采样世界空间反射。

### 注意

这个元素不包含采样方法。按照一般的用法，将世界空间反射参与到TextureCube的采样中。
而TextureCube所用的CubeMap可以是自定义的也可以使用UnityReflectProbe反射探针来制作。

### 关于反射

这里使用了CG 标准函数库中reflect来实现。
>>Article/CG/CG标准函数库

### 环境反射
结合CubeMap 或者MatCap 模拟周边环境反射。按照反射向量采样。

>TextureCube

参看文献 
>>Article/UnityBuiltIn/Unity中的环境反射