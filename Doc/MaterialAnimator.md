# MaterialAnimator 

材质动画

## 简介 

通过状态控制文件，提供程序控制对应材质的参数。
!(img/MaterialAnimator/1.jpg)


## 组件 
### MaterialAnimator 控制组件 

!(img/MaterialAnimator/2.jpg)

每一个需要控制材质动画的Renderer都需要绑定一个。
例如 角色有多个部位 头，头发，身体，配饰等等 那么每一个SkinnedMeshRenderer都需要绑定一个MaterialAnimator

### MaterialStateController 材质状态控制器 

!(img/MaterialAnimator/3.jpg)

MaterialAnimator需要绑定对应的Controller，因此理论上多少个Animator就需要多少个Controller。除非有材质是共用的，就可以共享。

状态控制机中分为2种状态。
1.	Default 必须存在也只有一个。用来填写默认情况。一般来说只要把做完的材质填在Materials列表中就可以了。
2.	States 特殊状态。这个列表需要美术自己定义。比如当前提供的Dither 颗粒透明效果。就需要定义2个状态Dither_Hide/Dither_Show。
分别定义了颗粒透明的隐藏和显示。
State/Materials 材质列表。和默认相同时填默认材质。如果有多材质模型就按照多材质顺序填。
State/Clips 参数列表。每一个参数都有from 和to 代表了动画开始值和动画结束值。
State/Clips/PropertyName 参数名。需要修改的材质参数名。<color="yellow">（注意）参数名指的是Shader内的名字不是面板中的显示名。约定俗成下 Shader内的名字就是 "_面板显示名"</color>
State/Clips/Type 参数类型 数值/颜色/数组/关键字 。其中关键字需要查看关键字说明(Mode/KeyWord)。
State/Duration 插值动画时间。以秒为单位
State/Curve 动画参数曲线。所有参数共享同一个曲线。

### Mode/KeyWord
!(img/MaterialAnimator/4.jpg)

KeyWord 是UnityShader中的一个特性。通过关键字可以将整体类似但有细微差别的Shader合并成同一个Shader。通过启用关键字来控制材质真正执行的Shader。
其中KeyWord是有Shader代码定义的，在当前的材质中主要涉及的2个自定义关键字。_MODE_DITHER/_MODE_DISSOLVE

### _MODE_DITHER 
抖动透明模式。
通过Control值控制透明度。

!(img/MaterialAnimator/5.jpg)

### _MODE_DISSOLVE 
溶解模式。
通过Control值控制透明度。
Dissolve_Pramas用以修改溶解效果。Dissolve_Pramas.xy(暂无作用)Dissolve_Pramas.z 溶解边缘亮度。>1 HDR高光 <0 变黑。Dissolve_Pramas.w 边缘溶解区域大小。

!(img/MaterialAnimator/6.jpg)

## 调试/程序相关 
MaterialAnimator配置完毕后。启动运行Unity。组件将出现测试按钮。分别为按照顺序播放所有State/播放Default

!(img/MaterialAnimator/7.jpg)

如果一个角色有多个部分需要协同调试，在这个角色根节点添加MaterialFX。运行后可以输入对应State名字播放动画。
