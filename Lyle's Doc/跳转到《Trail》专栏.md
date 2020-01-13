# Trail专栏
## 面向游戏中出现各种类型的Trail效果而很编写的Shader,基本上能满足于更类型的Trail需求。
***
### <color="#ffa500">概述：</color>
### 该Shader仅有一张Feature Texture来运算，通过RGB三个不同的通道来模拟Trail效果。但即便如此，也能有非常丰富的Trail效果。
|!(Img/Trail/Trail_01.gif)|<Size=13>←通过3通道组合不同的扭曲和主纹理达到各种不一样效果的拖尾效果，美术制作人员可以通过Properties轻松地控制拖尾的流速，长度，干扰程度，自发光，颜色权重等。</Size> 
***
### <color="#ffa500">原理（选读）：</color>
●Texture方面只需要一张Feature特征图，关于RGB三通道所需要绘制的图像，B Channel是Trail的主要形状。 R Channel与G Channel功能是一样的，都是用来做干扰主像素的UV。但R Channel还有一个功能，就是主贴图的纹理也是由它决定的。请注意这里指的是<color="#ff0000">纹理</color>，和我们前面提到的B Channel决定的<color="#ff0000">形状</color>是不一样的。形状是指代那些地方需要出现像素，而纹理是指出现像素的地方里面具体是什么样的。
|●关于R和G Channel 选用建议的是使用Noise类型的纹理，如图→|!(Img/Trail/Trail_R.jpg) 
|●关于B Channel选用建议是使用左右二方连续类型的纹理，如图→|!(Img/Trail/Trail_B.jpg) 
●我们选取其中三张图写入RGB为例，然后试着让其都往其中一个方向流动。
!(Img/Trail/RGBSroll.gif) 
●此时的B Channel是Trail效果的主纹理像素，一般是一张左右二方连续的贴图，因为需要连续滚动。当然有一种情况下也可以不是，这个我们下下面的用法中会详细说明。
●RG Channel则是干扰B Channel流动方向的像素，当然它们自身也是在滚动的，否则在像素上会非常呆板，在这个Shader中，流速是被写在代码中的，不在Properties中，所以美术人员不能通过参数调整它，一般也不会有不动的拖尾，所以不需要开放出来。但是该Shader的变体<color="#ffa500">Trail(STB)</color>开放出了流速参数的，后面我们会花部分篇幅来介绍这部分。
●接下来这部分就是Trail的核心算法部分，我们依然以图像的方式来呈现。首先我们将RG Channel合并（UV需要二分量来接入），然后用这部分的图像（二维数组）来干扰B Channel的UV流向。
|!(Img/Trail/RG-Channel.gif)|RG Channel合并。
|!(Img/Trail/B-Channel-Disolove.gif)|干扰后的B Channel。           
这时候我们先把这部分放一放。我们再来做另一组图。
●我们把R Channel和一张遮罩图相减。这部分就是我们前面提到的，R Channel为何会决定主贴图的<color="#ff0000">纹理</color>。             
|!(Img/Trail/R-Mask.gif)|我们能看见最终能得到一张和R Channel很相似的图，但是它的尾部是比较暗的，做出了Fade Out。
|!(Img/Trail/Mask-Variable.gif)|如果这个时候，我们再给本来不动的Mask图像暗部向右推，那么这部分的Fade Out就能控制长度。是否觉得这部分很熟悉？对的，这部分其实就是Trail的长度。 我们把这部分开出来的参数叫做<color="#70c776"><b>[Length]</b></color>。  
●但是目前看上去还不像是一个Trail，还记得之前那张干扰后的B Channel图像吗？我们需要它的<color="#ff0000">形状</color>，又需要目前的图像作为<color="#ff0000">纹理</color>。这里注意红色高亮的2个词，这就是我之前提到的为什么主贴图的<color="#ff0000">纹理</color>也是由R Channel决定的。而B Channel决定的是主要<color="#ff0000">形状</color>。
那要怎么做呢？我们很明白需要的是B Channel的<color="#ff0000">形状</color>，就是我们需要B Channel有图像的地方在R Channel减去Mask后的图像上显示出来。我们很自然会想到的就是乘法。于是我们将这两个图像相乘就可以了。
|!(Img/Trail/R-Mut-B.gif)|得到的图像就是Trail的图像雏形了，之后的颜色速度等等参数都是在这部分图像后做功能的。
***
### <color="#ffa500">用法：</color>
●如果你没有读过前面选读的部分，那么接下来关于RGB三通道如何绘制，那就必须按照规则来了，否则可能会出现各种各样的的硬切边等问题。
|!(Img/Trail/Trail_02.gif)|●这里需要你打破常规的Trail效果的刻板印象，Trail并不是简单的一个长条状，尾巴细长并且飘飘絮絮。除此之外，很多效果也可以用这个Shader来表现。 
●这里我们针对没有读过选读部分的读者再次解释一下RGB的绘制部分。
***
### -关于R Channel：
●R Channel有2个重要的功能：
-1.干扰Trail主贴图的UV。
-2.决定了Trail主贴图的纹理。                                                                                                                                                                                             

|因为这2个特性，因为关于R Channel绘制的一个建议是，尽量使用Noise型图像→|!(Img/Trail/Trail_R.jpg)
***
### -关于G Channel：
●G Channel的功能和R Channel几乎是一样的，但是G Channel和Trail主贴图的纹理没有任何关系，是的，它仅仅只是干扰Trail主贴图的UV。
●也因为G Channel仅仅只是干扰UV流向，使用在一定程度上，我们允许G Channel可以是空的，即不写入任何图像，但R Channel不可以，因为最终纹理还需要由R Channel来决定。
●我们也建议绘制的图像类型和R Channel一样是Noise类的图像。
***
### -关于B Channel：
●这几乎是最重要的一个通道，也是整个Trail图像的核心，一般修改基本上就是因为B Channel图像替换就会由截然不同的效果。所以效果上B Channel的图像是至关重要的的。
|●一般来说，要求图像是一张左右二方连续的图像，记住是左右，上下二方连续也是不行的，因为图像的流动是从左往右的。→|!(Img/Trail/Trail_B.jpg)
●有一种特殊情况下，图像是可以不为二方连续的。就是在<color="#70c776"><b>[Speed]</b></color>参数为0的情况下，因为为0的情况下本身这个通道就不流动，所以也不会出现切面。
***
### -关于Property：
●<color="#70c776"><b>[ColorStart]</b></color>与<color="#70c776"><b>[ColorEnd]</b></color>：为了丰富Trail的颜色，在颜色上做了多样性变化，令Trail效果可以拥有2种颜色，而不是单调的单色。这里就需要2个参数<color="#70c776"><b>[ColorStart]</b></color>与<color="#70c776"><b>[ColorEnd]</b></color>。其中<color="#70c776"><b>[ColorStart]</b></color>代表的是Trail头部，也就是起始位置的颜色，<color="#70c776"><b>[ColorEnd]</b></color>则是尾部，即结束部分的颜色，我们能在下面2图中看到非常直观的示意。
|!(Img/Trail/ColorStart.gif)|调整<color="#70c776"><b>[ColorStart]</b></color>参数的调色板，就能更改起始位置的颜色。
|!(Img/Trail/ColorEnd.gif)|调整<color="#70c776"><b>[ColorEnd]</b></color>参数的调色板，就能更改结束部分的颜色。
***
●<color="#70c776"><b>[Color Weight]</b></color>：这个参数与<color="#70c776"><b>[ColorStart]</b></color>，<color="#70c776"><b>[ColorEnd]</b></color>相关。前面我们已经谈到<color="#70c776"><b>[ColorStart]</b></color>与<color="#70c776"><b>[ColorEnd]</b></color>分别控制的是头尾的颜色数值，那中间到底哪部分开始的是头部的颜色，哪部分开始是尾部的颜色，也就是它们的分界点在哪里呢？这里我们就引入一个“<color="#70c776"><b>[Color Weight]</b></color>”的数值。这个数值就用于控制头尾颜色的权重，到底是头部的颜色比重大一点，还是尾部的颜色比重大一点。我们从下图的示意中能看到很好的表现。
|!(Img/Trail/Color Weight.gif)|<color="#70c776"><b>[Color Weight]</b></color>的数值接近0，则颜色往<color="#70c776"><b>[ColorStart]</b></color>的颜色偏向多一些，反之则偏向<color="#70c776"><b>[ColorEnd]</b></color>。
***
|●<color="#70c776"><b>[Length]</b></color>：就如字面所述，这是Trail的长度。数值越小，长度越短，反之亦然。但是做了限定参数，即使数值为0，长度也不会为0,否则拖尾会消失，所以这是一个相对数值。|!(Img/Trail/Length.gif)
***
●<color="#70c776"><b>[FlowStrenght]</b></color>：我们提到RG Channel会干扰B Channel的流动，而这个干扰有一个强度，就是<color="#70c776"><b>[FlowStrenght]</b></color>。这个干扰数值越高，受到的扰动程度就越大,为0则不受干扰。
|!(Img/Trail/FlowStrenght.gif)|图为<color="#70c776"><b>[FlowStrenght]</b></color>在不同数值下的表现。
***
●<color="#70c776"><b>[Speed]</b></color>：这是决定主贴图形状速度的一项参数。小则慢，大则快，为零则静止不动。
|!(Img/Trail/Speed.gif)|图为<color="#70c776"><b>[Speed]</b></color>在不同数值下，Trail速度的变化。
—眼尖的读者可能发现了，上图中<color="#70c776"><b>[Speed]</b></color>数值为0，但是依然有一定的流动动态。或许你也反应过来了，这是由于<color="#70c776"><b>[FlowStrenght]</b></color>参数的影响，所以产生了一定的干扰效果。其实这个说法只对了一半，我们来看看当<color="#70c776"><b>[FlowStrenght]</b></color>和<color="#70c776"><b>[Speed]</b></color>都为0是否画面就静止了，来验证一下这个想法。
|!(Img/Trail/Speed2.gif)|如图所示，即使<color="#70c776"><b>[FlowStrenght]</b></color>和<color="#70c776"><b>[Speed]</b></color>都为0，Trail还是具有一定的动态。这确实和<color="#70c776"><b>[FlowStrenght]</b></color>有一定关系，<color="#70c776"><b>[FlowStrenght]</b></color>是强度，本身要产生强度就需要有一定的速度值，否则就只是让主贴图产生变形而已。而这个速度值是写进Shader并且固定的。
而我们在做主贴图纹理的时候，是通过R Channel减去一张Mask来获得的，而这个R Channel的流动速度，和RG Channel干扰用的速度引用的是同一个数值。于是主纹理的速度也来源于这里，即使形状已经不动了，纹理还是在动。
注意这里说的是“引用同一个值”，并不是说R Channel的速度和RG Channel的速度就是这个数值，我们用下面一张图来说明引用数值之间的关系。
|!(Img/Trail/Sketch.jpg)|由图可知B Channel的速度是直接和这个引用值挂钩的。这个引用值就是我们前面提到的，写进Shader的固定值，非开放且不能更改。而之所以RG Channel的速度可以更改，是因为多乘以了一个参数C，0乘任何数都为0，所以当参数C为0的时候，RG Channel的流速就等于0了。也许聪明你的注意到了：“那这个参数C就是开放出来的参数<color="#70c776"><b>[Speed]</b></color>的嘛！”不错，这等于是一个转接器A接了一个转接器B，更改转接器B不会影响到转接器A，因为转接器A还被转接器C转接，直接更改转接器A会对转接器C也有影响，而这并不是我们所希望的。
在该Shader的变体<color="#ffa500">Trail(STB)</color>中，“被引用的参数A”是被开放出来的，但是这么做的缺点很明显。只要这个数值为0，那么整个Trail的动态就是静止的。
***
|●<color="#70c776"><b>[Emission]</b></color>：一个决定Trail亮度的参数，越高数值发光越明显，如果这个数值为0，那么整个Trail将不被显示。|!(Img/Trail/Emission.gif)
***
### <color="#ffa500">写法：</color>
该Shader由ShaderForge编写，但此处则去掉ShaderForge模板代码，点击下列查看代码。
/{ 点击查看代码
```
Shader "Lyle/Trail" {
    Properties {
        _FeatureTexture ("Feature Texture", 2D) = "white" {}
        [HDR]_ColorStart ("ColorStart", Color) = (1,0.7421881,0.1273585,1)
        [HDR]_ColorEnd ("ColorEnd", Color) = (0.226965,0,0.6037736,1)
        _ColorWeight ("Color Weight", Range(0, 3)) = 1.122898
        _Length ("Length", Range(0, 1)) = 1
        _FlowStrength ("FlowStrength", Range(0, 1)) = 0
        _Emission ("Emission", Float ) = 1
        _Speed ("Speed", Float ) = 1
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform sampler2D _FeatureTexture; uniform float4 _FeatureTexture_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _Length)
                UNITY_DEFINE_INSTANCED_PROP( float, _FlowStrength)
                UNITY_DEFINE_INSTANCED_PROP( float4, _ColorStart)
                UNITY_DEFINE_INSTANCED_PROP( float4, _ColorEnd)
                UNITY_DEFINE_INSTANCED_PROP( float, _ColorWeight)
                UNITY_DEFINE_INSTANCED_PROP( float, _Speed)
                UNITY_DEFINE_INSTANCED_PROP( float, _Emission)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                UNITY_FOG_COORDS(1)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
////// Emissive:
                float4 _ColorStart_var = UNITY_ACCESS_INSTANCED_PROP( Props, _ColorStart );
                float4 _ColorEnd_var = UNITY_ACCESS_INSTANCED_PROP( Props, _ColorEnd );
                float U = i.uv0.r;
                float _ColorWeight_var = UNITY_ACCESS_INSTANCED_PROP( Props, _ColorWeight );
                float4 node_2435 = _Time;
                float _Speed_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Speed );
                float4 node_5710 = _Time;
                float2 node_9274 = (i.uv0+node_5710.g*float2(-1,0));
                float4 node_4074 = tex2D(_FeatureTexture,TRANSFORM_TEX(node_9274, _FeatureTexture));
                float _FlowStrength_var = UNITY_ACCESS_INSTANCED_PROP( Props, _FlowStrength );
                float node_1964 = U;
                float2 UV = i.uv0;
                float2 node_2514 = ((node_2435.g*float2((-1*_Speed_var),0.0))+(float2(node_4074.r,node_4074.g)*_FlowStrength_var*node_1964)+UV);
                float4 node_2175 = tex2D(_FeatureTexture,TRANSFORM_TEX(node_2514, _FeatureTexture));
                float _Length_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Length );
                float node_3262 = (node_2175.b*saturate(((node_4074.r+clamp((1.0 - i.uv0.r),0.25,0.75))-(node_1964*((1.0 - _Length_var)*4.5+0.5)))));
                float3 emissive = (lerp(_ColorStart_var.rgb,_ColorEnd_var.rgb,(U*_ColorWeight_var))*node_3262);
                float3 finalColor = emissive;
                float _Emission_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Emission );
                float V = i.uv0.g;
                float node_2699 = V;
                float Mask = saturate(((1.0 - U)*(1.0 - node_2699)*3.0*node_2699));
                fixed4 finalRGBA = fixed4(finalColor,(node_3262*_Emission_var*Mask));
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma target 3.0
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
```
/}