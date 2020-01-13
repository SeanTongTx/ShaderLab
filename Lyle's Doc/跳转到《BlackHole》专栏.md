# BlackHole专栏
## BlackHole特殊类Shader,该类Shader有2个Type。
***
### <color="#ffa500">BlackHole Type1概述：</color>
### BlackHole特殊类型Shader其一。由一张主图作为背景，一张Feature贴图写入RGBA四个不同通道的数据来模拟黑洞效果。该Shader优点在于性能，面数，贴图大小上的节省。
●如果该Shader应用于Unity自带的Particle System上，朝向为Billboard，那么对于Mesh的要求就非常简单，仅仅需要一个三角面即可，背面的图像不需要绘制出来，所有的图像变化也仅仅在一个Mesh面上运算但是能以Billboard的特性，
达到看上去类似一个球体的效果，即模拟黑洞，若在Unity自带的Particle System上使用，还会进行批处理即使发射了100个黑洞其Draw Call指令仅为1，三角面也仅为100。但是这种做法的表现方式极为有限，若是想要极为丰富多变的表现，则不推荐用Type1。
|!(Img/BlackHole/BlackHole002.gif)|●该Shader的变体<color="#ffa500">BlackHole Type1(Billboard)</color>则自带Billboard特性，缺点是这种做法自身没有办法进行批处理，图为Billboard效果。
***
### <color="#ffa500">原理：</color>

●Texture方面采用Feature Texture和一张Main Texture，最终Feature Texture计算出来的图像会加到Main Texture上。
●关于Feature Texture的画法会在使用说明中提及，Main Texture的一个选用建议是，尽可能是云雾状，或者星空图案，见下图。
!(Img/BlackHole/BlackHole003.jpg)
!(Img/BlackHole/BlackHole004.jpg)
●一张由RGBA不同通道构成不同要素的特征图。
***
###<color="#ffa500">用法：</color>
### -关于R Channel：
●决定了黑洞的外边缘，需要小心的是，A通道是决定黑洞形状，因此R通道中的边缘图最好在A通道之内，否则超出的部分像素也会被A通道的遮罩剔除。
|!(Img/BlackHole/Outline Color.jpg)|●除此之外，还有4项Properties与之相关,<color="#70c776"><b>[Outline Color],[Outline Color2],[Weight],[Weight Type]。</b></color>
***
|!(Img/BlackHole/OutlineColor1.gif)|●如左图所见，<color="#70c776"><b>[Outline Color]与[Outline Color2]</b></color>同时能够控制外边缘颜色，2个颜色的范围各为一半，当然其中的权重也通过<color="#70c776"><b>[Weight]</b></color>可以控制，见下图。
***
|!(Img/BlackHole/OutlineColor2.gif)|●<color="#70c776"><b>[Weight]</b></color>属性用于控制外边缘的颜色权重。当<color="#70c776"><b>[Weight]</b></color>数值接近0时，颜色倾向权重靠近<color="#70c776"><b>[Outline Color2]</b></color>，为0时则颜色即为<color="#70c776"><b>[Outline Color2]</b></color>，即<color="#70c776"><b>[Outline Color]</b></color>无效，反之则亦然。
●<color="#70c776"><b>[Weight Type]</b></color>则是颜色权重的一个类别，会将<color="#70c776"><b>[Outline Color]与[Outline Color2]</b></color>的颜色相反，默认为关闭，打开后<color="#70c776"><b>[Outline Color]与[Outline Color2]</b></color>的颜色会对调。
***
### -关于G Channel：
●观察G通道中的图像，会发现是一颗颗大小不均的点颗粒(Particle)，这是用来模拟碎尘，星尘向内收缩的的效果。但是需要注意，这些点可不像图像那么直观向中心走，因为此处G通道采用的做法是极坐标算法，来使得点向中间收拢。
|所以你看到的通道虽然是这样的:|!(Img/BlackHole/G channel01.jpg)
|但是它实际算出来却会是这样的:|!(Img/BlackHole/G channel02.jpg)
●那么如何让颗粒拉伸起来不要那么夸张，尽量接近原图呢？这里采取了一个折中的办法。也就是接下来要说的与G Channel关联的几个Properties<color="#70c776"><b>[Parram(XY：Particle Speed& ZW：Tile)]</b></color>。
!(Img/BlackHole/G channel03.jpg)
●仔细观察<color="#70c776"><b>[Parram(XY：Particle Speed& ZW：Tile)]</b></color>这栏四分量，括号内表明的XYWZ分别代表的什么样的Properties。刚才的问题关联到ZW代表的Propertie，这里指出了Tile，即G通道的重铺值。
***
|!(Img/BlackHole/G channel04.gif)|●通过减少X方向的重铺值来让颗粒变得更加具有纵向的朝向，符合向内流动的效果。
***
|!(Img/BlackHole/G channel05.gif)|●而XY的Propertie则如字面所描述，是颗粒(Particle)的Speed。一般是向内流动，所以X方向一般是有速度的，Y则不给速度，因为Y如果产生流速，这些颗粒(Particle)则会产生类似旋转的效果。
***
|!(Img/BlackHole/G channel06.gif)|●还有一项相关的参数就是颗粒(Particle)的颜色，这里通过<color="#70c776"><b>[Particle Color]</b></color>来控制。
***
### -关于B Channel：
|!(Img/BlackHole/Warp.gif)|●观察B通道会发现是一个边缘羽化的点，这是一张用来扭曲黑洞内部的像素。与之关联的是<color="#70c776"><b>[Param(XY：HoleSpeed Z：Depth W：Warp)]</b></color>中的<color="#70c776"><b>[W：Warp]</b></color>，代表了扭曲的程度。
***
### -关于A Channel：
<color="#70c776"><b>[Z：Depth]</b></color>这其实是一张遮罩图。仔细观察4个Channel不难发现所有的Channel都不会超出A Channel的范围，这是因为超出的部分会被A Channel的像素遮出来。这也就是为什么R Channel要画在A Channel之内。
***
### -关于其他的Properties
●<color="#70c776"><b>[Main Color]</b></color>:上述中我们提到了，该Shader需要一张尽可能是云雾状，或者星空图案来模拟宇宙。<color="#70c776"><b>[Main Color]</b></color>正是用来给这张主图着色的参数，即<color="#70c776"><b>[Main Texture]</b></color>的贴图颜色。
●<color="#70c776"><b>[Param(XY：HoleSpeed Z：Depth W：Warp)]</b></color>:上述中我们已经提及了这组四分量参数中的<color="#70c776"><b>[W：Warp]</b></color>用法。余下的<color="#70c776"><b>[XY：HoleSpeed]</b></color>是<color="#70c776"><b>[Main Texture]</b></color>贴图UV的流动速度。<color="#70c776"><b>[Z：Depth]</b></color>这个参数则比较特殊，我们放到下面专门来说明。
###-关于Z Depth：
●多数情况下，我们的黑洞是游浮于空中的，但是有时候也有例外的情况，黑洞需要往地面上靠近，于是会出现极为明显的切边情况。<color="#70c776"><b>[Z：Depth]</b></color>就是应对处理这种情况。
|!(Img/BlackHole/Zdepth1.gif)|如左图，此处的的<color="#70c776"><b>[Z：Depth]</b></color>为0，即等于没有<color="#70c776"><b>[Z：Depth]</b></color>的效果，所以出现的硬切边现象。
|!(Img/BlackHole/Zdepth2.gif)|如左图，当我们将<color="#70c776"><b>[Z：Depth]</b></color>设置为0.5时，就会出现较为柔和的软切边。
|!(Img/BlackHole/Zdepth3.gif)|如左图,当<color="#70c776"><b>[Z：Depth]</b></color>设置为1时，则更为明显。
注：推荐<color="#70c776"><b>[Z：Depth]</b></color>数值在1以下，超出1时可能会羽化掉不该消失的部分。
***
### <color="#ffa500">写法：</color>
该Shader由ShaderForge编写，但此处则去掉ShaderForge模板代码，点击下列查看代码。
/{ 点击查看代码
```
 Shader "Lyle/BlackHole Type1" {
    Properties {
        _MainTexture ("Main Texture", 2D) = "white" {}
        _Feature ("Feature", 2D) = "white" {}
        [HDR]_MainColor ("Main Color", Color) = (1,1,1,1)
        [HDR]_ParticleColor ("Particle Color", Color) = (1,1,1,1)
        _ParamXYHoleSpeedZDepthWWarp ("Param(XY：HoleSpeed Z：Depth W：Warp)", Vector) = (0,0,0,0)
        _ParramXYParticleSpeedZWTile ("Parram(XY：Particle Speed& ZW：Tile)", Vector) = (0,0,0,0)
        [HDR]_OutlineColor ("Outline Color", Color) = (1,1,1,1)
        [HDR]_OutlineColor2 ("Outline Color2", Color) = (0.5,0.5,0.5,1)
        _Weight ("Weight", Float ) = 1
        [MaterialToggle] _WeightType ("Weight Type", Float ) = 0
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
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma target 3.0
            uniform sampler2D _CameraDepthTexture;
            uniform sampler2D _Feature; uniform float4 _Feature_ST;
            uniform sampler2D _MainTexture; uniform float4 _MainTexture_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _OutlineColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _ParticleColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _MainColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _ParamXYHoleSpeedZDepthWWarp)
                UNITY_DEFINE_INSTANCED_PROP( float4, _ParramXYParticleSpeedZWTile)
                UNITY_DEFINE_INSTANCED_PROP( float4, _OutlineColor2)
                UNITY_DEFINE_INSTANCED_PROP( float, _Weight)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _WeightType)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 projPos : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float sceneZ = max(0,LinearEyeDepth (UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)))) - _ProjectionParams.g);
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
////// Lighting:
////// Emissive:
                float4 _OutlineColor2_var = UNITY_ACCESS_INSTANCED_PROP( Props, _OutlineColor2 );
                float4 _OutlineColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _OutlineColor );
                float _WeightType_var = lerp( i.uv0.g, i.uv0.r, UNITY_ACCESS_INSTANCED_PROP( Props, _WeightType ) );
                float _Weight_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Weight );
                float4 node_3263 = tex2D(_Feature,TRANSFORM_TEX(i.uv0, _Feature));
                float4 _ParticleColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _ParticleColor );
                float2 node_2495 = (i.uv0*2.0+-1.0).rg;
                float4 node_2621 = _Time;
                float4 _ParramXYParticleSpeedZWTile_var = UNITY_ACCESS_INSTANCED_PROP( Props, _ParramXYParticleSpeedZWTile );
                float2 node_5482 = ((float2(length(node_2495),((atan2(node_2495.r,node_2495.g)/6.28318530718)+0.5))+(node_2621.g*float2(_ParramXYParticleSpeedZWTile_var.r,_ParramXYParticleSpeedZWTile_var.g)))*float2(_ParramXYParticleSpeedZWTile_var.b,_ParramXYParticleSpeedZWTile_var.a));
                float4 node_1304 = tex2D(_Feature,TRANSFORM_TEX(node_5482, _Feature));
                float4 _MainColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _MainColor );
                float4 node_6993 = tex2D(_Feature,TRANSFORM_TEX(i.uv0, _Feature));
                float BChanel = node_6993.b;
                float4 _ParamXYHoleSpeedZDepthWWarp_var = UNITY_ACCESS_INSTANCED_PROP( Props, _ParamXYHoleSpeedZDepthWWarp );
                float node_7245_ang = (BChanel*_ParamXYHoleSpeedZDepthWWarp_var.a);
                float node_7245_spd = 1.0;
                float node_7245_cos = cos(node_7245_spd*node_7245_ang);
                float node_7245_sin = sin(node_7245_spd*node_7245_ang);
                float2 node_7245_piv = float2(0.5,0.5);
                float2 node_7245 = (mul(i.uv0-node_7245_piv,float2x2( node_7245_cos, -node_7245_sin, node_7245_sin, node_7245_cos))+node_7245_piv);
                float2 node_5504 = (node_7245+(sceneUVs * 2 - 1).rg+(node_2621.g*float2(_ParamXYHoleSpeedZDepthWWarp_var.r,_ParamXYHoleSpeedZDepthWWarp_var.g)));
                float4 _MainTexture_var = tex2D(_MainTexture,TRANSFORM_TEX(node_5504, _MainTexture));
                float3 emissive = ((lerp(_OutlineColor2_var.rgb,_OutlineColor_var.rgb,(_WeightType_var*_Weight_var))*node_3263.r)+(_ParticleColor_var.rgb*node_1304.g)+(_MainColor_var.rgb*_MainTexture_var.rgb));
                float3 finalColor = emissive;
                float Opacity = node_3263.a;
                return fixed4(finalColor,(Opacity*saturate((sceneZ-partZ)/_ParamXYHoleSpeedZDepthWWarp_var.b)));
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    
```
/}
***
## 小结：
<color="#ffa500">●BlackHole Type1</color>虽然在效果上有其一定的局限性，但是也带来了一些便利。当然并不能应对所有情况，只能针对某些需求使用，并且也不打算做成泛用性极高的一种Shader，在泛用性和效率上，总要妥协于一方。所以有了<color="#ffa500">●BlackHole Type2</color>来弥补它的不足。
●优点：
-极低的面数需求，仅一个三角面。
-简单的Feature Texture制作。
●缺点：
-由于Billboard特性，缩放没办法斜向。即使在拉伸模式下，正面显示则不正常，满足不了形变的运动规律。
***
### <color="#ffa500">BlackHole Type2概述(未完成)</color>
