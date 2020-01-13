# MipMap的LOD实现原理 
(https://blog.csdn.net/u013467442/article/details/46444673)

当使用MipMap时我们可能会遇到tex2D，tex2Dbias，tex2Dgrad，tex2Dlod几种纹理采样函数。

在PS中tex2D自动计算应该使用的纹理层。

tex2Dbias需要在t.w中指定一个偏移量来把自动计算出的纹理层全部偏移指定的值。

tex2Dgrad需要提供屏幕坐标x和y方向上的梯度来确定应该使用的纹理层。

<color="red">tex2Dlod需要在t.w中明确指定要使用的纹理层。</color>

In the PS the LOD is determined from the derivatives of the texCoords automatically(tex2D). You can also specify the derivatives explicitly as two extra arguments

tex2D(textureMap, texCoord, ddx(texCoord), ddy(texCoord))
is equivalent to your tex2D, though of course you could use something else as the derivative.
Alternately, you can use tex2Dlod to explicitly select the LOD speicifed by the 'w' component of texCoord; eg, something like:
``` 核心代码
tex2Dlod(textureMap, float4(texCoord.xy, 0, lod))
```
在Shader中使用tex2D(tex, uv)的时候相当于在GPU内部展开成下面：
tex2D(sampler2D tex, float4 uv)
{
    float lod = CalcLod(ddx(uv), ddy(uv));
    uv.w= lod;
    return tex2Dlod(tex, uv);
}

计算MipMap层函数：

float mipmapLevel(float2 uv, float2 textureSize)
{
    float dx = ddx(uv * textureSize.x);
    float dy = ddy(uv * textureSize.y);
    float d = max(dot(dx, dx), dot(dy, dy));  
    return 0.5 * log2(d);//0.5是技巧，本来是d的平方。
} 