# ShaderLab/Lapis
Lapis Re:Lights项目使用风格
*** 注意 ***
<color="yellow">每一个风格都是所有资源协作的结果,贴图，法线，网格，uv，渲染管线，后处理等等</color>
!(img/Lapis/1.jpg)
## Adapter<color="yellow">注意</color>
适配旧的Shader。部分旧的Shader改写后适配新的写法，当然最好还是不要使用旧的。
### Adapter_***
直接修改旧有名为***的shader适配新的Shader写法。唯一的目的是让以前有的材质动画兼容。
<color="yellow">注意以后不要再用</color>。

## Character
卡通角色,兼容了<color="white">材质特效 抖动透明，溶解</color>参考MaterialAnimator
>MaterialAnimator
### Character/Body
渲染皮肤或者纯贴图的衣服。基本前向渲染路径。
·MainTex 颜色贴图
·Ramp 卡通光照分布
·Shadow 阴影颜色贴图，其中Shadow.a蒙版不受光照影响的阴影。
!(img/Lapis/Shadow.jpg)
LOD :
·400 支持平行光，外描边，卡通光照，像素光照，阴影投射，阴影细节，内描边。(<color="white">材质特效</color>)
·300 支持阴影细节，平行光，卡通光照,内描边，像素光照，阴影投射。(<color="white">材质特效</color>)
·250 支持支持阴影细节，平行光，卡通光照,内描边。(<color="white">材质特效</color>)
·200 支持平行光，卡通光照。
·min 支持顶点级光照颜色

### Character/Brow
渲染眉毛(...)实在是太小了只使用顶点光照
·MaintTex 颜色贴图
·Ramp 卡通光照分布
LOD :
·300 支持平行光，卡通光照，阴影投射。(<color="white">材质特效</color>)
·200 支持平行光。
·min 支持顶点级光照颜色

### Character/Eye
渲染眼睛。眼睛在Lapis中用凹面椭圆做，不能按照原本的光照处理。
暂时不处理平行光，也就不处理卡通光照。但是面积比较大，需要处理像素光
·MaintTex 颜色贴图
LOD ：
·250 平行光颜色，像素光。（<color="white">材质特效</color>)
·min 顶点击光照颜色

### Character/Face
渲染面部。面部主要还是在模型法线需要胶囊展开，没有内描边。其他处理基本和Body相同
同时有额外的面部红晕，使用MainTex.a来控制红晕区域。
!(img/Lapis/Face.jpg)
·MainTex 颜色贴图
·Ramp 卡通光照分布
·Shadow 阴影颜色贴图，其中Shadow.a蒙版不受光照影响的阴影。
LOD :
·400 支持平行光，外描边，卡通光照，像素光照，阴影投射，阴影细节，红晕区域。(<color="white">材质特效</color>)
·300 支持阴影细节，平行光，卡通光照，像素光照，阴影投射，红晕区域。(<color="white">材质特效</color>)
·250 支持支持阴影细节，平行光，卡通光照，红晕区域。(<color="white">材质特效</color>)
·200 支持平行光，卡通光照，红晕区域。
·min 支持顶点级光照颜色

### Character/Hair
渲染头发。完全等同于Body。

***
## Scene
场景物件渲染。项目用maya特定方法渲染光照贴图，因此lightmap算法独特。
特殊光照贴图参数如下
!(img/Lapis/Scene.jpg)
_LightMapParams
x.暗部最低值
y.亮部最高值
z.光照贴图权重
w.透明度 
### Scene/LightMapOpaque
不透明普通场景物件。
·Texture 颜色特图
·LightMap 光照贴图
LOD：
·200 支持平行光颜色，光照贴图，unity雾效
·min 平行光颜色
### Scene/LightMapCutOut
透明剔除的场景物件。比如植被
·Texture 颜色特图
·LightMap 光照贴图
LOD：
·200 支持平行光颜色，光照贴图，unity雾效
·min 平行光颜色

### Scene/LightMapAlphaBlend
透明融合的场景物件。半透明窗户之类
·Texture 颜色特图
·LightMap 光照贴图
LOD：
·200 支持平行光颜色，光照贴图，unity雾效
·min 平行光颜色

***

## Cloth
服装相关。
<color="yellow">这类Shader只为特殊服装效果服务，可能对模型，贴图等有要求。</color>
因为服装一定和角色相关，因此基本配置参考Character/Body。以下只描述特殊的参数。
这类型的材质对渲染压力较大，整体LOD等级偏高。
### Cloth/Gauze
半透明纱布。有特殊的薄纱光照模拟。通过前后2个pass来渲染半透明。
!(img/Lapis/Gauze.jpg)
·MainTex 在a通道中添加透明度
·Alpha 半透明权重
·RimPower 边缘效应权重
LOD:
·500 支持平行光 薄纱光照模拟，双pass半透明，像素光照，阴影投射，阴影细节，材质特效，内描边
·400 支持平行光 卡通光照模拟，双pass半透明，像素光照，阴影投射，阴影细节，材质特效
·300 支持平行光 卡通光照模拟，单pass半透明，像素光照,阴影投射,阴影细节，材质特效
·250 支持平行光 卡通光照模拟，单pass半透明，阴影细节，材质特效
·200 支持平行光，卡通光照，单pass半透明。
·min 支持顶点级光照颜色 不透明

***

## Effect(Legcy)
特效相关。基本从原OZ/Effect下移植，修改了绝大多数通过Shaderforge之类的生成器代码实现问题。
去掉多此一举的编译，参数转换等。
修改了大部分毫无意义的像素运算。
移除了大多数特效的光照计算。毫无意义。
尽可能的增加LOD设置。
增加了MRT支持。
规范化颜色输出：相似的参数，有相似的亮度输出。
<color="red">红色字体，表示差异性修改[注意]相同参数可能会与原来的效果有略微的差异</color>
<color="yellow">原来OZ特效中有太多半透明的特效，但是各种ZWriteOn CullBack可能有特殊用途就没改了</color>

### Effect/Dissolution
原=Shader Forge/Oz_Effect_Dissolution 
溶解，支持模型2套UV
!(img/Lapis/Dissolution.jpg)

### Effect/DissolutionAdd
叠加模式溶解，支持原图和蒙版的UV流动。
<color="red">降低了重复叠加的HDR亮度，因为叠加模式，这会导致亮度急剧升高</color>
!(img/Lapis/DissolutionAdd.jpg)
### Effect/DissolutionBlend
透明度混合溶解，DissolutionAdd 变体。
### Effect/RotAdd
旋转叠加，支持原图uv旋转
!(img/Lapis/Rot_Add.jpg)

### Effect/Blade
原=Oz/Effect/Blade 看名字应该是刀..光..吧
实际是 2张贴图UV流动叠加，有一个Turb增加了采样混合度
!(img/Lapis/Blade.jpg)

### Effect/BladeBlend
原=Oz/Effect/BladeBlend Blade变体Turb没了

### Effect/BlueBell
原=Oz_Effect_BlueBell 蓝球？゛(‘◇’)?迷一般的3层贴图叠加
!(img/Lapis/BlueBell.jpg)

### Effect/ColorHDR
原=Oz_Effect_ColorHDR
叠加透明，HDR颜色
!(img/Lapis/ColorHDR.jpg)

### Effect/ColorHDR_Twinkle
原=Shader Forge/Oz_Effect_ColorHDR_AddNoise
和Noise一点关系都没有也没有HDR颜色<┐(￣ヘ￣)┌>
实际是：按照一定速度闪烁 ColorHDR变体

### Effect/ColorHDR_Blend
原= Shader Forge/Oz_Effect_ColorHDR_Alpha 
原= Oz/Effect/ColorHDR_Blend
ColorHDR变体 混合模式

### Effect/Disa
原=Shader Forge/Oz_Effect_Disa 半透明+挖空？Disa？不知道是什么意思
!(img/Lapis/Disa.jpg)

### Effect/Distort
原=Oz/Effect/Distort 扭曲。使用了GrabPass但没有用Normal采样。
算法不明觉厉，放弃优化。(〃'▽'〃)
!(img/Lapis/Distort.jpg)

### Effect/Fresnel
原=Oz/Effect/FresnelOnly 边缘光
!(img/Lapis/Fresnel.jpg)

### Effect/FresnelRoll
原=Oz/Effect/FresnelRoll 
支持原图和蒙版的UV流动+2套uv+边缘光+平行光？。
整体饱和度太高，像素计算特复杂，大概是妙用，不敢改。
!(img/Lapis/FresnelRoll.jpg)

### Effect/FresnelRoll_01
原=Oz_Effect_FresnelRoll01 除了边缘光和FresnelRoll一点关系也没有
实际上是边缘光+华丽丽的4贴图UV流动叠加。妙用，不改。

### Effect/FresnelRoll_02
原=Shader Forge/Oz_Effect_FresnelRoll02 UV流动都没有和FresnelRoll一毛钱关系没有。
实际是边缘透明。+3张贴图叠加。妙，不改。

### Effect/Fresnel_Blend
原=Oz/Effect/LoveBlend 爱的融合？(ｷ｀ﾟДﾟ´)!!有诗意。
Effect/Fresnel的变体。增加了贴图和颜色控制。

### Effect/Mask_Add
原=Oz/Effect/Mask Add 是Effect/BladeBlend变体，增加了2套UV支持

### Effect/Fresnel_OutLine
原=Oz/Effect/OutLine 
描边+Fresnel，双面材质但是不透明。妙不改。
!(img/Lapis/Fresnel_OutLine.jpg)

### Effect/SandClock
原=Oz/Effect/SandClock 沙漏特有。妙不改。
### Effect/SandClock2
原=Oz/Effect/SandClock2 沙漏特有。妙不改。
### Effect/FresnelRoll_Screen
原=Shader Forge/Oz_Effect_ScreenUV 屏幕空间UV流动+Fresnel。妙不改

### Effect/Shield
原=Oz/Effect/Shield 护盾特有。妙不改。
!(img/Lapis/Shield.jpg)

### Effect/SpeedLine
原=Oz/Effect/SpeedLine 速度线。妙不改。
!(img/Lapis/SpeedLine.jpg)
### Effect/Trail
原=Oz/Effect/Trail 应该是拖尾相关。妙不改。

### Effect/ColorHDR_UVScale
原=Shader Forge/Oz_Effect_UVScale 蒙版半透明。
UV缩放和我理解中的缩放不太一样。妙不改。

### Effect/ColorHDR_UVSroll
原=Oz/Effect/UVSroll 。UV流动+HDR颜色融合
似曾相识，类似的效果太多了。妙不改。

### Effect/VertexDirOffset
原=Oz/Effect/VertexDirOffset 。顶点变形。
x控制顶点缩放，y控制整体偏移，z控制alpha
这是啥？(#ﾟДﾟ),猜测是脚底阴影。妙不可言。不改。

### Effect/VertexOffset
原=Shader Forge/Oz_Effect_VertexOffset 。又一个顶点变形。
通过贴图采样控制顶点偏移。在顶点阶段采样的话对GPU有一点小要求。有UV流动。妙不。

### Effect/WeaponGemAdd
原=Oz/Effect/WeaponGemAdd。应该是宝石锤子上面的宝石。
超级多控制参数，除了做的人没人能改。妙不。
### Effect/WeaponGemBlend
同上

### Effect/ColorHDR_Wing
翅膀吧