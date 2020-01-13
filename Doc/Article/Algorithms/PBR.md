# ShaderLab/PBR

近年来PBR越发流行，即便在移动端越来越多的使用BxDF代替原来的模型。
还是要认真的从原理出发学习一下PBR。
这篇 主要的是学习笔记 和核心知识记录。
方便以后查阅。

# BxDF
(https://blog.csdn.net/poem_qianmo/article/details/88936992)
!(Algorithms/微屏幕理论.jpg)
QA 微平面理论
每个表面点将来自给定进入方向的光反射到单个出射方向，该方向取决于微观几何法线（microgeometry normal）m的方向。 
在计算BRDF项时，指定光方向l和视图方向v。 
这意味着所有表面点，只有那些恰好正确朝向可以将l反射到v的那些小平面可能有助于BRDF值（其他方向有正有负，积分之后，相互抵消）。

我们可以看到这些“正确朝向”的表面点的表面法线m正好位于l和v之间的中间位置。
l和v之间的矢量称为半矢量（half-vector）或半角矢量（half-angle vector）; 我们将其表示为h。


仅m = h的表面点的朝向才会将光线l反射到视线v的方向，其他表面点对BRDF没有贡献。

并非所有m = h的表面点都会积极地对反射做出贡献;一些被l方向（阴影shadowing），v方向（掩蔽masking）或两者的其他表面区域阻挡。
Microfacet理论假设所有被遮蔽的光（shadowed light）都从镜面反射项中消失;
实际上，由于多次表面反射，其中一些最终将是可见的，但这在目前常见的微平面理论中一般并未去考虑，各种类型的光表面相互作用如下图所示

QA

### 微表面法线:m
### 光线:l
### 视线:v
### l和v之间的矢量称为半矢量：h


!(Algorithms/微屏幕遮蔽和阴影.jpg)

QA Microfacet Cook-Torrance BRDF

D（h）：法线分布函数 （Normal Distribution Function），描述微面元法线分布的概率，即正确朝向的法线的浓度。即具有正确朝向，能够将来自l的光反射到v的表面点的相对于表面面积的浓度。
F（l，h）: 菲涅尔方程（Fresnel Equation），描述不同的表面角下表面所反射的光线所占的比率。
G(l，v，h): 几何函数（Geometry Function）：描述微平面自成阴影的属性，即m = h的未被遮蔽的表面点的百分比。
分母 4（n·l）（n·v） ：校正因子（correctionfactor），作为微观几何的局部空间和整个宏观表面的局部空间之间变换的微平面量的校正。

对于分母中的点积，仅仅避免负值是不够的 - 也必须避免零值。通常通过在常规的clamp或绝对值操作之后添加非常小的正值来完成。
QA
![](Algorithms/BRDF.jpg)

## 漫反射项（Diffuse）：Disney Diffuse
漫反射最终收敛值由粗糙度决定 而不是简单的0

![](Algorithms/Diffuse.jpg)

## 法线分布项（Specular D）：GTR

![](Algorithms/Specular D.jpg)
### c为缩放常数（scaling constant）

### α为粗糙度参数（roughness parameter）其值在0和1之间;α=0产生完全平滑的分布（即θh = 0时的delta函数），α=1产生完全粗糙或均匀的分布。

主波瓣（primary lobe）

使用γ= 2的GTR（即GGX分布）

代表基础底层材质（Base Material）的反射

可为各项异性（anisotropic） 或各项同性（isotropic）的金属或非金属

次级波瓣（secondary lobe）

使用γ= 1的GTR（即Berry分布）

代表基础材质上的清漆层（ClearCoat Layer）的反射

一般为各项同性（isotropic）的非金属材质，即清漆层（ClearCoat Layer）


## Specular F Schlick
!(Algorithms/Specular F.jpg)

### 常数F0表示垂直入射时的镜面反射率

##  几何项（Specular G）：Smith-GGX
!(Algorithms/SpecularGSmith-GGX.jpg)

### α 从[0, 1]重映射到[0.5, 1]，α的值为(0.5 + roughness/2)^2