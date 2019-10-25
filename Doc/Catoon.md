# ShaderLab/Styles
渲染器模板，方便程序写Shader
## 简介 
依照Shader代码格式生成代码。不同于美术用ShaderEditor这个是代码向的。
整体结构按照风格->功能->变体 构建。

## 结构性规范
1·ShaderLab中所有Shader必须以ShaderLab命名 <color="white">[ShaderLab/**/***]</color>
2·所有的Shader必须放在Shaders目录下。
3·所有的Cginc库必须放置在Shaders/Cgincs中。
4·Shader分类规范[风格]/[目标]/功能
5·移植项目时,需要完整移植整个Shader目录。

## Debug 
调试Shader提供了各种基础数据的直接展示。
!(img/Debug.jpg)

## MaterialAnimator 
材质动画控制器。详细参考
>MaterialAnimator

## Generator <color="red">(Internal)</color>
Shader代码生成器。
生成Shader模板。也可以打开Shader代码并解析成模板。
通过可视化操作为Shader添加代码，主要是添加常用数据结构。