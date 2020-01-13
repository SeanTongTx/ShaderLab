# ComputeScreenPos函数
## 简介 
顾名思义计算屏幕坐标。
但是实际上结果值有点微妙。
来看源码
``` Unity核心代码
//pos:ClipPos 裁剪空间的位置
inline float4 ComputeScreenPos (float4 pos)
{
    float4 o = pos * 0.5f;
    o.xy = float2(o.x, o.y*_ProjectionParams.x) + o.w;
    o.zw = pos.zw;
    return o;
}
```
_ProjectionParams 是当前投影器(Camera)的ViewPort
x = 1,如果投影翻转则x = -1
y是camera近裁剪平面
z是camera远裁剪平面
w是1/远裁剪平面

首先齐次坐标变换到屏幕坐标：顶点在变换到齐次坐标后，其x和y分量的范围在[-w, w]。
屏幕的宽度为width，高度为height，那么屏幕坐标的计算方法为：
``` 原始算式
screenPosX = ((x / w) * 0.5 + 0.5) * width
screenPosY = ((y / w) * 0.5 + 0.5) * height
```
移位、两边*w
``` 转换算式
posX/width*w=(x*0.5+0.5*w)
posY/height*w=(y*0.5+0.5*w)

即

uv.x*w=0.5*(pos.x+pos.w)
uv.y*w=0.5*(pos.y+pos.w)

```

所以ComputeScreenPos 输出的xy范围是在[0,w]
因此在采样前需要/w,再进行采样。

### 为什么Unity要这么做呢？

Unity的本意是希望你把该坐标值用作tex2Dproj指令的参数值，tex2Dproj会在对纹理采样前除以w分量。
不过很多时候屏幕uv的计算不只是为了采样。
``` 常见用法
pos = UnityObjectToClipPos(v.vertex);
screenPos = ComputeScreenPos(o.pos);
tex2D(_ScreenTex, float2(screenPos.xy / screenPos.w))
```