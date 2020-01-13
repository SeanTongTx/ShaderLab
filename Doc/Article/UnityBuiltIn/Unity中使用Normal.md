# Unity中使用Normal 

## 模型法线
``` 模型法线
half3 normal : NORMAL;
```
## 法线贴图

切空间法线贴图在存储时会将[-1,1]的分量方向编码到[0,1]之间，这样贴图才能存储。
算法是 pixel = (normal + 1) / 2
在Unity中解码法线贴图，一般使用UnityCG内置方法UnpackNormal
UnpackNormal函数的内部实现（在UnityCG.cginc里）
```UnpackNormal
inline fixed3 UnpackNormalDXT5nm (fixed4 packednormal)
{
	fixed3 normal;
	normal.xy = packednormal.wy * 2 - 1;
#if defined(SHADER_API_FLASH)
	// Flash does not have efficient saturate(), and dot() seems to require an extra register.
	normal.z = sqrt(1 - normal.x*normal.x - normal.y * normal.y);
#else
	normal.z = sqrt(1 - saturate(dot(normal.xy, normal.xy)));
#endif
	return normal;
}
 
inline fixed3 UnpackNormal(fixed4 packednormal)
{
#if (defined(SHADER_API_GLES) || defined(SHADER_API_GLES3)) && defined(SHADER_API_MOBILE)
	return packednormal.xyz * 2 - 1;
#else
	return UnpackNormalDXT5nm(packednormal);
#endif
}
```
可以看到，Unity的实现中包含了DXT5法线贴图解析。其原因可以参看CG法线贴图压缩的部分
>>Article/CG/法线贴图
### Texture Type
在Unity中法线贴图需要将TextureType设置成“Normal Map”，这样的设置可以让Unity根据不同平台对纹理进行压缩。
![](UnityBuiltIn/img/NormalMap.jpg)
### Create from grayscale
通过高度图生成法线贴图。

## 使用NormalMap

UnpackNormal之后 解码出的贴图法线依然是切线空间下的向量。
因此有2种解法：将其他需要计算的参数转换到切空间下。或将切空间法线转换到世界空间。

### 转到世界空间计算
切空间->世界空间转换矩阵
``` 转换矩阵
float3 worldPos = mul(_Object2World,v.vertex).xyz;
fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
fixed3 worldBinormal = cross(worldNormal,worldTangent)*v.tangent.w;

o.TtoW0=float4(worldTangent.x,worldBinomal.x,worldNormal.x,worldPos.x);
o.TtoW1=float4(worldTangent.y,worldBinomal.y,worldNormal.y,worldPos.y);
o.TtoW2=float4(worldTangent.z,worldBinomal.z,worldNormal.z,worldPos.z);
```
其中内置方法 UnityObjectToWorldNormal(也在UnityCG中)将法线从模型空间转换到世界空间。
``` object2world
// Transforms normal from object to world space
inline float3 UnityObjectToWorldNormal( in float3 norm )
{
	// Multiply by transposed inverse matrix, actually using transpose() generates badly optimized code
	return normalize(_World2Object[0].xyz * norm.x + _World2Object[1].xyz * norm.y + _World2Object[2].xyz * norm.z);
}
```
当然自己用内置矩阵转也是一样的
``` o2w
worldNormal = normalize(mul(v.normal, (float3x3)_World2Object));
```
UnityObjectToWorldDir 将向量又Object空间转换到世界空间中
```
// Transforms direction from object to world space
inline float3 UnityObjectToWorldDir( in float3 dir )
{
    return normalize(mul((float3x3)unity_ObjectToWorld, dir));
}
```
以世界法线和世界切线座位正交基 计算出第三轴 副切线 worldBinormal

最后在从贴图中采样切空间法线 按照转换矩阵转置
```
fixed3 normal = UnpackNormal(tex2D(_NormalMap,i.uv));
worldNormal = nomalize(half3(dot(i.TtoW0.xyz,normal),dot(i.TtoW1.xyz,normal)),dot(i.TtoW2.xyz,normal)));
```

### 利用Unity内置宏 

TANGENT_SPACE_ROTATION; //获取模型空间转切空间转换矩阵
```
// Declares 3x3 matrix 'rotation', filled with tangent space basis
 #define TANGENT_SPACE_ROTATION \
    float3 binormal = cross( normalize(v.normal), normalize(v.tangent.xyz) ) * v.tangent.w; \
    float3x3 rotation = float3x3( v.tangent.xyz, binormal, v.normal )
```
>切线空间


### 引用

(https://blog.csdn.net/candycat1992/article/details/41605257)