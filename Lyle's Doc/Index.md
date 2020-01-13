# Lyle's Shader Lib

## 整理目前开发中所使用的着色器，其制作方法不限。
***
### ●归纳开发中所使用的特效Shader为主，也有触及部分场景及动态Shader。
### ●目前大部分由Amplify Shader Editor，Shader Forge等可视化编辑器制作，部分由其修改而来。
### ●不定期更新，部分用法和实例也会写入其中，提供模板式开发，提高制作效率。
***
/{<color="#ffa500">-BlackHole</color>
>跳转到《BlackHole》专栏
!(Img/BlackHole.gif)
### ●特殊型BlackHole类型Shader。针对处理黑洞基础效果编写，基于RGBA通道特殊Feature贴图模拟黑洞的边缘高亮，中心点颗粒收拢等效果，详见跳转专栏。
/}
***
/{<color="#ffa500">-Trail</color>
>跳转到《Trail》专栏
!(Img/Trail.gif)
### ●通用型Trail类型Shader。面向处理多样化的Trail效果，基于RGBA通道特殊Feature贴图作用，模拟流动，噪波，Trail的流向的扰动。该类Shader分为2个Type，详见跳转专栏。
/}
***
/{<color="#ffa500">-Dissolve</color>
>跳转到《Dissolve》专栏
!(Img/Dissolve.gif)
### ●通用型issolve类型Shader。由一张对比图与主图对比产生半透明消失效果，并带有溶解边缘效果。该类Shader有所分向，目前提供2个较为稳定的版本，但没有提供Additive的版本，详见跳转专栏。
/}
***
/{<color="#ffa500">-Mask</color>
>跳转到《Mask》专栏
!(Img/Mask.gif)
### ●通用型Mask遮罩Shader。算法由2张贴图相乘而来，接入了RGB颜色，Main贴图和Mask贴图的颜色都具备颜色数值，并且开放出UV偏移速度。该类Shader提供Additive与AlphaBlend版本，详见跳转专栏。
/}
***
/{<color="#ffa500">-Gem</color>
>跳转到《Gem》专栏
!(Img/Gem.gif)
### ●特殊型Gem类型Shader，针对宝石类编写的特效Shader。该类Shader不受光源影响，没有真实的反射高光。呈现的高光和颗粒基于贴图和UV错杂来模拟，仅供一类型特效表现使用，各部分细节由一张Feature图控制。详见跳转专栏。
/}