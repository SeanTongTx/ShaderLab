# ShaderLab <color="yellow">(Alpha)</color>
着色器实验室，方便程序写Shader
## 简介 
依照Shader代码格式生成代码。不同于美术用ShaderEditor这个是代码向的。
整体结构按照风格(项目)->功能->变体 构建。
## 更新说明
>Version
## 结构性规范
1·ShaderLab中所有Shader必须以ShaderLab命名 <color="white">[ShaderLab/**/***]</color>
2·所有的Shader必须放在Shaders目录下。
3·所有的Cginc库必须放置在Shaders/Cgincs中。
4·Shader分类规范[风格]/[目标]/功能
5·移植项目时,需要完整移植整个Shader目录。

## 风格
所有shader 按照风格大分类。保证每个风格独立成体系。
值得注意的是，风格和shader并没有绝对的关系，可能会出现很多风格公用一套shader代码的情况。
或者看似相似的2个风格，代码完全不同。具体的使用场景单独处理。
风格列表
1·Sean 自定义
>Sean
2·Lapise 项目用(Obsolete)
>Lapis
## 算法
这个专栏只为了研究和记录各种形式的算法。
>Algorithms

## Debug 
调试Shader提供了各种基础数据的直接展示。
!(img/Debug.jpg)

## ShaderLOD

VertexLit kind of shaders = 100
Decal, Reflective VertexLit = 150
Diffuse = 200
Diffuse Detail, Reflective Bumped Unlit, Reflective Bumped VertexLit = 250
Bumped, Specular = 300
Bumped Specular = 400
Parallax = 500
Parallax Specular = 600
为了可以统一管理，ShaderLab中所有Shader都应该符合这标准。
参考Unity ShaderLOD。
(https://docs.unity3d.com/Manual/SL-ShaderLOD.html)

## MaterialAnimator 
材质动画控制器。详细参考
>MaterialAnimator

## ShaderLaboratory <color="red">(Internal)</color>(未实现)
Shader代码生成器。
生成Shader模板。也可以打开Shader代码并解析成模板。
通过可视化操作为Shader添加代码，主要是添加常用数据结构。
通过不断添加代码模板增加 降低写Shader的复杂度。
