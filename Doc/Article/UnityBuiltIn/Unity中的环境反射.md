# Unity中的环境反射 

首先这篇关注的镜面环境反射。即非PBR中按照直线光反射角的计算以及模拟。

```代码
	//得到反射方向
    float3 reflectDir=reflect(-viewDir,i.normal);即/*WORLD_REFLECT*/
    //得到环境采样
    float4 envSample = UNITY_SAMPLE_TEXCUBE(unity_SpecCube0, reflectDir);
    //天空盒可能是HDR的，要转回普通的颜色
    Out =DecodeHDR(envSample, unity_SpecCube0_HDR);
```
1·unity_SpecCube0 即反射探针（天空盒和后面的反射探针形成的立体贴图）

2·UNITY_SAMPLE_TEXCUBE 用于采样立体贴图

3·DecodeHDR将高动态贴图转为正常RGB， unity_SpecCube0_HDR.xy和颜色的alpha通道（M）存储了转化的信息

>>Article/Algorithms/HDRM与HDRI编码

## 反射探针

反射探针有3种用法
1·Bake 烘焙静态物体。
2·Realtime 实时计算，有几种时间片的选择。大体上就是每个2帧或者4帧或者在Awake时烘焙一遍。
3·Custom 手动指定一个Cubemap。

在PBR中 常用反射贴图的mipmap模拟粗糙度

Unity会为环境贴图生成不同层级的mipmap，0-5级从模糊到清晰，所以UNITY_SPECCUBE_LOD_STEPS定义为6。

粗糙度是光滑度的相反，

粗糙度和mipmap不是线性的关系，所以要转化一下

m=1.7r-0.7r^2
```Lod模拟粗糙度
float roughness = 1 - _Smoothness;

roughness *= 1.7 - 0.7 * roughness;

float4 envSample = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflectDir,roughness*UNITY_SPECCUBE_LOD_STEPS);
```
### Box Projection
开启BoxProjection，根据物体的位置来采样。
不开则认为反射点在反射探针框的中心位置。那么无论物体在方框内的哪个位置，同一个角度采样得到的数据都是一样的。


引用:
(https://blog.csdn.net/qq_38275140/article/details/86145803)