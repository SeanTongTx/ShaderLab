// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33759,y:32402,varname:node_3138,prsc:2|emission-6516-OUT,alpha-9712-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32360,y:32549,ptovrint:False,ptlb:Outside_Color,ptin:_Outside_Color,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:9712,x:33421,y:32970,varname:node_9712,prsc:2|A-6450-A,B-8630-OUT;n:type:ShaderForge.SFN_Fresnel,id:3044,x:31756,y:33039,varname:node_3044,prsc:2|NRM-7101-OUT,EXP-9021-OUT;n:type:ShaderForge.SFN_Multiply,id:5989,x:32643,y:32594,varname:node_5989,prsc:2|A-7241-RGB,B-3044-OUT;n:type:ShaderForge.SFN_ValueProperty,id:9021,x:31471,y:33111,ptovrint:False,ptlb:Fresnel_intensity,ptin:_Fresnel_intensity,varname:node_9021,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:2;n:type:ShaderForge.SFN_OneMinus,id:1568,x:31692,y:33227,varname:node_1568,prsc:2|IN-7425-OUT;n:type:ShaderForge.SFN_Fresnel,id:7425,x:31471,y:33219,varname:node_7425,prsc:2|EXP-1532-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1532,x:31240,y:33253,ptovrint:False,ptlb:Fresnel_inside_intensity,ptin:_Fresnel_inside_intensity,varname:_qiangdu_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.2;n:type:ShaderForge.SFN_Add,id:8630,x:32792,y:33043,varname:node_8630,prsc:2|A-3044-OUT,B-5341-OUT;n:type:ShaderForge.SFN_Tex2d,id:9494,x:31798,y:32780,ptovrint:False,ptlb:Inside_Testure,ptin:_Inside_Testure,varname:node_9494,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:6945bf0661873244c8940c589aad845a,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:4286,x:32207,y:33095,varname:node_4286,prsc:2|A-9494-B,B-918-OUT;n:type:ShaderForge.SFN_Multiply,id:5341,x:32464,y:33162,varname:node_5341,prsc:2|A-4286-OUT,B-3642-OUT;n:type:ShaderForge.SFN_ValueProperty,id:3642,x:32253,y:33288,ptovrint:False,ptlb:Inside_intensity,ptin:_Inside_intensity,varname:node_3642,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:5;n:type:ShaderForge.SFN_Add,id:5071,x:32818,y:32428,varname:node_5071,prsc:2|A-5989-OUT,B-6360-OUT;n:type:ShaderForge.SFN_Color,id:9450,x:31836,y:32161,ptovrint:False,ptlb:Inside_color,ptin:_Inside_color,varname:node_9450,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Tex2d,id:6450,x:32567,y:32157,ptovrint:False,ptlb:Testures,ptin:_Testures,varname:node_6450,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Add,id:6516,x:33061,y:32277,varname:node_6516,prsc:2|A-5563-OUT,B-5071-OUT;n:type:ShaderForge.SFN_Power,id:918,x:31933,y:33251,varname:node_918,prsc:2|VAL-1568-OUT,EXP-4855-OUT;n:type:ShaderForge.SFN_Vector1,id:4855,x:31692,y:33381,varname:node_4855,prsc:2,v1:1.5;n:type:ShaderForge.SFN_Tex2d,id:778,x:31491,y:32230,ptovrint:False,ptlb:NoiseA,ptin:_NoiseA,varname:node_778,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:c33bc9caff7930e44bc0fed8387e9afe,ntxv:0,isnm:False|UVIN-5515-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:2519,x:30957,y:32239,varname:node_2519,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_TexCoord,id:1076,x:30957,y:32464,varname:node_1076,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Panner,id:5515,x:31259,y:32230,varname:node_5515,prsc:2,spu:0.01,spv:-0.005|UVIN-2519-UVOUT;n:type:ShaderForge.SFN_Panner,id:3297,x:31259,y:32467,varname:node_3297,prsc:2,spu:-0.015,spv:-0.024|UVIN-1076-UVOUT;n:type:ShaderForge.SFN_Add,id:5849,x:31707,y:32500,varname:node_5849,prsc:2|A-778-RGB,B-2751-RGB;n:type:ShaderForge.SFN_Tex2d,id:2751,x:31491,y:32467,ptovrint:False,ptlb:NoiseB,ptin:_NoiseB,varname:node_2751,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:6b3f0ff0320fba8479684cc5c35aacce,ntxv:0,isnm:False|UVIN-3297-UVOUT;n:type:ShaderForge.SFN_NormalVector,id:7101,x:31471,y:32919,prsc:2,pt:False;n:type:ShaderForge.SFN_Multiply,id:6360,x:32267,y:32368,varname:node_6360,prsc:2|A-9450-RGB,B-8630-OUT,C-5849-OUT;n:type:ShaderForge.SFN_Color,id:4731,x:32567,y:31918,ptovrint:False,ptlb:Testures_Color,ptin:_Testures_Color,varname:node_4731,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:5563,x:32822,y:32062,varname:node_5563,prsc:2|A-4731-RGB,B-6450-RGB;proporder:4731-6450-7241-9021-1532-9494-9450-3642-778-2751;pass:END;sub:END;*/

Shader "ShaderLab/Lapis/Effect/FresnelRoll01" {
    Properties {
        [HDR]_Testures_Color ("Testures_Color", Color) = (0.5,0.5,0.5,1)
        _Testures ("Testures", 2D) = "white" {}
        [HDR]_Outside_Color ("Outside_Color", Color) = (1,1,1,1)
        _Fresnel_intensity ("Fresnel_intensity", Float ) = 2
        _Fresnel_inside_intensity ("Fresnel_inside_intensity", Float ) = 0.2
        _Inside_Testure ("Inside_Testure", 2D) = "white" {}
        [HDR]_Inside_color ("Inside_color", Color) = (0.5,0.5,0.5,1)
        _Inside_intensity ("Inside_intensity", Float ) = 5
        _NoiseA ("NoiseA", 2D) = "white" {}
        _NoiseB ("NoiseB", 2D) = "white" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma target 3.0
            uniform float4 _Outside_Color;
            uniform float _Fresnel_intensity;
            uniform float _Fresnel_inside_intensity;
            uniform sampler2D _Inside_Testure; uniform float4 _Inside_Testure_ST;
            uniform float _Inside_intensity;
            uniform float4 _Inside_color;
            uniform sampler2D _Testures; uniform float4 _Testures_ST;
            uniform sampler2D _NoiseA; uniform float4 _NoiseA_ST;
            uniform sampler2D _NoiseB; uniform float4 _NoiseB_ST;
            uniform float4 _Testures_Color;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float4 _Testures_var = tex2D(_Testures,TRANSFORM_TEX(i.uv0, _Testures));
                float node_3044 = pow(1.0-max(0,dot(i.normalDir, viewDirection)),_Fresnel_intensity);
                float4 _Inside_Testure_var = tex2D(_Inside_Testure,TRANSFORM_TEX(i.uv0, _Inside_Testure));
                float node_8630 = (node_3044+((_Inside_Testure_var.b*pow((1.0 - pow(1.0-max(0,dot(normalDirection, viewDirection)),_Fresnel_inside_intensity)),1.5))*_Inside_intensity));
                float4 node_9887 = _Time;
                float2 node_5515 = (i.uv0+node_9887.g*float2(0.01,-0.005));
                float4 _NoiseA_var = tex2D(_NoiseA,TRANSFORM_TEX(node_5515, _NoiseA));
                float2 node_3297 = (i.uv0+node_9887.g*float2(-0.015,-0.024));
                float4 _NoiseB_var = tex2D(_NoiseB,TRANSFORM_TEX(node_3297, _NoiseB));
                float3 node_6516 = ((_Testures_Color.rgb*_Testures_var.rgb)+((_Outside_Color.rgb*node_3044)+(_Inside_color.rgb*node_8630*(_NoiseA_var.rgb+_NoiseB_var.rgb))));
                float3 emissive = node_6516;
                float3 finalColor = emissive;
                return fixed4(finalColor,(_Testures_var.a*node_8630));
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
