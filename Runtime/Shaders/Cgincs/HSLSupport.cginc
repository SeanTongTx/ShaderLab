// Desaturate （彩度を下げる）
float4 Desaturate(float3 color, float Desaturation) 
{ 
    float3 grayXfer = float3(0.3, 0.59, 0.11); 
    float grayf = dot(grayXfer, color); 
    float3 gray = float3(grayf, grayf, grayf); 
    return float4(lerp(color, gray, Desaturation), 1.0); 
}

// RGBToHSL （RGB値 からHSL値（色相・彩度・明度）に変換
float3 RGBToHSL(float3 color)
{
    // init to 0 to avoid warnings ? (and reverse if + remove first part)
    float3 hsl;
    //Min. value of RGB
    float fmin = min(min(color.r, color.g), color.b);
    //Max. value of RGB
    float fmax = max(max(color.r, color.g), color.b);
    //Delta RGB value
    float delta = fmax - fmin;
    // Luminance
    hsl.z = (fmax + fmin) / 2.0;

    if (delta == 0.0)        //This is a gray, no chroma...
    {
        hsl.x = 0.0;    // Hue
        hsl.y = 0.0;    // Saturation
    }
    else                                    //Chromatic data... 
    {
        if (hsl.z < 0.5)
            hsl.y = delta / (fmax + fmin); // Saturation
        else
            hsl.y = delta / (2.0 - fmax - fmin); // Saturation

        float deltaR = (((fmax - color.r) / 6.0) + (delta / 2.0)) / delta;
        float deltaG = (((fmax - color.g) / 6.0) + (delta / 2.0)) / delta;
        float deltaB = (((fmax - color.b) / 6.0) + (delta / 2.0)) / delta;

        if (color.r == fmax )
            hsl.x = deltaB - deltaG; // Hue
        else if (color.g == fmax)
            hsl.x = (1.0 / 3.0) + deltaR - deltaB; // Hue
        else if (color.b == fmax)
            hsl.x = (2.0 / 3.0) + deltaG - deltaR; // Hue

        if (hsl.x < 0.0)
            hsl.x += 1.0; // Hue
        else if (hsl.x > 1.0)
            hsl.x -= 1.0; // Hue
    }

    return hsl;
}

//HueToRGB（色相からRGB値を計算）
float HueToRGB(float f1, float f2, float hue)
{
    if (hue < 0.0)
        hue += 1.0;
    else if (hue > 1.0)
        hue -= 1.0;
    float res;
    if ((6.0 * hue) < 1.0)
        res = f1 + (f2 - f1) * 6.0 * hue;
    else if ((2.0 * hue) < 1.0)
        res = f2;
    else if ((3.0 * hue) < 2.0)
        res = f1 + (f2 - f1) * ((2.0 / 3.0) - hue) * 6.0;
    else
        res = f1;
    return res;
}

//HSLToRGB（HSL値 からRGBに変換）
float3 HSLToRGB(float3 hsl)
{
    float3 rgb;

    if (hsl.y == 0.0)
        rgb = float3(hsl.z, hsl.z, hsl.z); // Luminance
    else
    {
        float f2;
        
        if (hsl.z < 0.5)
            f2 = hsl.z * (1.0 + hsl.y);
        else
            f2 = (hsl.z + hsl.y) - (hsl.y * hsl.z);
            
        float f1 = 2.0 * hsl.z - f2;
        
        rgb.r = HueToRGB(f1, f2, hsl.x + (1.0/3.0));
        rgb.g = HueToRGB(f1, f2, hsl.x);
        rgb.b= HueToRGB(f1, f2, hsl.x - (1.0/3.0));
    }
    
    return rgb;
}

//コントラスト・彩度・明度 の調整
float3 ContrastSaturationBrightness(float3 color, float brt, float sat, float con) 
{ 
    // Increase or decrease theese values to adjust r, g and b color channels seperately 
    const float AvgLumR = 0.5; 
    const float AvgLumG = 0.5; 
    const float AvgLumB = 0.5; 
    
    const float3 LumCoeff = float3(0.2125, 0.7154, 0.0721); 
    
    float3 AvgLumin = float3(AvgLumR, AvgLumG, AvgLumB); 
    float3 brtColor = color * brt; 
    float intensityf = dot(brtColor, LumCoeff); 
    float3 intensity = float3(intensityf, intensityf, intensityf); 
    float3 satColor = lerp(intensity, brtColor, sat); 
    float3 conColor = lerp(AvgLumin, satColor, con); 
    return conColor; 
}

// PhotoShop Blendモード用ファンクション定義
#define BlendLinearDodgef             BlendAddf 
#define BlendLinearBurnf             BlendSubstractf 
#define BlendAddf(base, blend)         min(base + blend, 1.0) 
#define BlendSubstractf(base, blend)     max(base + blend - 1.0, 0.0) 
#define BlendLightenf(base, blend)         max(blend, base) 
#define BlendDarkenf(base, blend)         min(blend, base) 
#define BlendLinearLightf(base, blend)     (blend < 0.5 ? BlendLinearBurnf(base, (2.0 * blend)) : BlendLinearDodgef(base, (2.0 * (blend - 0.5)))) 
#define BlendScreenf(base, blend)         (1.0 - ((1.0 - base) * (1.0 - blend))) 
#define BlendOverlayf(base, blend)     (base < 0.5 ? (2.0 * base * blend) : (1.0 - 2.0 * (1.0 - base) * (1.0 - blend))) 
#define BlendSoftLightf(base, blend)     ((blend < 0.5) ? (2.0 * base * blend + base * base * (1.0 - 2.0 * blend)) : (sqrt(base) * (2.0 * blend - 1.0) + 2.0 * base * (1.0 - blend))) 
#define BlendColorDodgef(base, blend)     ((blend == 1.0) ? blend : min(base / (1.0 - blend), 1.0)) 
#define BlendColorBurnf(base, blend)     ((blend == 0.0) ? blend : max((1.0 - ((1.0 - base) / blend)), 0.0)) 
#define BlendVividLightf(base, blend)     ((blend < 0.5) ? BlendColorBurnf(base, (2.0 * blend)) : BlendColorDodgef(base, (2.0 * (blend - 0.5)))) 
#define BlendPinLightf(base, blend)     ((blend < 0.5) ? BlendDarkenf(base, (2.0 * blend)) : BlendLightenf(base, (2.0 *(blend - 0.5)))) 
#define BlendHardMixf(base, blend)     ((BlendVividLightf(base, blend) < 0.5) ? 0.0 : 1.0) 
#define BlendReflectf(base, blend)         ((blend == 1.0) ? blend : min(base * base / (1.0 - blend), 1.0)) 
//カラーブレンド式の定義
#define Blend(base, blend, funcf)         float3(funcf(base.r, blend.r), funcf(base.g, blend.g), funcf(base.b, blend.b))
#define BlendNormal(base, blend)         (base)
#define BlendLighten                BlendLightenf
#define BlendDarken                BlendDarkenf
#define BlendMultiply(base, blend)         (base * blend)
#define BlendAverage(base, blend)         ((base + blend) / 2.0)
#define BlendAdd(base, blend)         min(base + blend, float3(1.0, 1.0, 1.0))
#define BlendSubstract(base, blend)     max(base + blend - float3(1.0, 1.0, 1.0), float3(0.0, 0.0, 0.0))
#define BlendDifference(base, blend)     abs(base - blend)
#define BlendNegation(base, blend)     (float3(1.0, 1.0, 1.0) - abs(float3(1.0, 1.0, 1.0) - base - blend))
#define BlendExclusion(base, blend)     (base + blend - 2.0 * base * blend)
#define BlendScreen(base, blend)         Blend(base, blend, BlendScreenf)
#define BlendOverlay(base, blend)         Blend(base, blend, BlendOverlayf)
#define BlendSoftLight(base, blend)     Blend(base, blend, BlendSoftLightf)
#define BlendHardLight(base, blend)     BlendOverlay(blend, base)
#define BlendColorDodge(base, blend)     Blend(base, blend, BlendColorDodgef)
#define BlendColorBurn(base, blend)     Blend(base, blend, BlendColorBurnf)
#define BlendLinearDodge            BlendAdd
#define BlendLinearBurn            BlendSubstract
#define BlendLinearLight(base, blend)     Blend(base, blend, BlendLinearLightf)
#define BlendVividLight(base, blend)     Blend(base, blend, BlendVividLightf)
#define BlendPinLight(base, blend)         Blend(base, blend, BlendPinLightf)
#define BlendHardMix(base, blend)         Blend(base, blend, BlendHardMixf)
#define BlendReflect(base, blend)         Blend(base, blend, BlendReflectf)
#define BlendGlow(base, blend)         BlendReflect(blend, base)
#define BlendPhoenix(base, blend)         (min(base, blend) - max(base, blend) + float3(1.0, 1.0, 1.0))
#define BlendOpacity(base, blend, F, O)     (F(base, blend) * O + blend * (1.0 - O))

// 色相ブレンド
float3 BlendHue(float3 base, float3 blend)
{
    float3 baseHSL = RGBToHSL(base);
    return HSLToRGB(float3(RGBToHSL(blend).r, baseHSL.g, baseHSL.b));
}

//彩度ブレンド
float3 BlendSaturation(float3 base, float3 blend)
{
    float3 baseHSL = RGBToHSL(base);
    return HSLToRGB(float3(baseHSL.r, RGBToHSL(blend).g, baseHSL.b));
}

//カラーブレンド
float3 BlendColor(float3 base, float3 blend) 
{
    float3 blendHSL = RGBToHSL(blend);
    return HSLToRGB(float3(blendHSL.r, blendHSL.g, RGBToHSL(base).b));
}

//明度ブレンド
float3 BlendLuminosity(float3 base, float3 blend)
{
    float3 baseHSL = RGBToHSL(base);
    return HSLToRGB(float3(baseHSL.r, baseHSL.g, RGBToHSL(blend).b));
}
