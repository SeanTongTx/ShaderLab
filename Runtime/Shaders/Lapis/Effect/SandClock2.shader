// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32881,y:32485,varname:node_3138,prsc:2|emission-5298-OUT,alpha-6125-OUT;n:type:ShaderForge.SFN_Tex2dAsset,id:6218,x:30778,y:32879,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_6218,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:9889ea8a368482f428a8fbc38ffb7ec4,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:4069,x:31838,y:32708,varname:node_4069,prsc:2,tex:9889ea8a368482f428a8fbc38ffb7ec4,ntxv:0,isnm:False|UVIN-2960-OUT,TEX-6218-TEX;n:type:ShaderForge.SFN_Slider,id:500,x:30837,y:32427,ptovrint:False,ptlb:ParticleSpeed,ptin:_ParticleSpeed,varname:node_500,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-5,cur:-0.8281062,max:5;n:type:ShaderForge.SFN_Time,id:8981,x:30837,y:32271,varname:node_8981,prsc:2;n:type:ShaderForge.SFN_Multiply,id:9126,x:31218,y:32430,varname:node_9126,prsc:2|A-8981-T,B-500-OUT;n:type:ShaderForge.SFN_TexCoord,id:4913,x:31218,y:32262,varname:node_4913,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:25,x:31352,y:32419,varname:node_25,prsc:2|A-4913-V,B-9126-OUT;n:type:ShaderForge.SFN_Append,id:7917,x:31554,y:32455,varname:node_7917,prsc:2|A-4913-U,B-25-OUT;n:type:ShaderForge.SFN_Set,id:3402,x:31065,y:32290,varname:Time,prsc:2|IN-8981-T;n:type:ShaderForge.SFN_Set,id:3954,x:31218,y:32171,varname:U,prsc:2|IN-4913-U;n:type:ShaderForge.SFN_Set,id:7729,x:31218,y:32112,varname:V,prsc:2|IN-4913-V;n:type:ShaderForge.SFN_Slider,id:6528,x:30898,y:33107,ptovrint:False,ptlb:ShakeSpeed,ptin:_ShakeSpeed,varname:node_6528,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Get,id:9827,x:31034,y:33017,varname:node_9827,prsc:2|IN-3402-OUT;n:type:ShaderForge.SFN_Multiply,id:2387,x:31261,y:33056,varname:node_2387,prsc:2|A-9827-OUT,B-6528-OUT;n:type:ShaderForge.SFN_Add,id:9388,x:31528,y:33047,varname:node_9388,prsc:2|A-3109-OUT,B-2387-OUT;n:type:ShaderForge.SFN_Get,id:3109,x:31261,y:32999,varname:node_3109,prsc:2|IN-7729-OUT;n:type:ShaderForge.SFN_Append,id:2125,x:31781,y:32997,varname:node_2125,prsc:2|A-5387-OUT,B-9388-OUT;n:type:ShaderForge.SFN_Get,id:5387,x:31496,y:32985,varname:node_5387,prsc:2|IN-3954-OUT;n:type:ShaderForge.SFN_Tex2d,id:5289,x:31998,y:32997,varname:node_5289,prsc:2,tex:9889ea8a368482f428a8fbc38ffb7ec4,ntxv:0,isnm:False|UVIN-2125-OUT,TEX-6218-TEX;n:type:ShaderForge.SFN_Multiply,id:5000,x:31352,y:32603,varname:node_5000,prsc:2|A-9785-OUT,B-5398-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5398,x:31159,y:32672,ptovrint:False,ptlb:ShakeInt,ptin:_ShakeInt,varname:node_5398,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.03;n:type:ShaderForge.SFN_RemapRange,id:9785,x:31007,y:32602,varname:node_9785,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-5289-B;n:type:ShaderForge.SFN_Add,id:2960,x:31554,y:32585,varname:node_2960,prsc:2|A-7917-OUT,B-5000-OUT;n:type:ShaderForge.SFN_Color,id:4597,x:31838,y:32524,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_4597,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.2696244,c2:0.539391,c3:0.6886792,c4:1;n:type:ShaderForge.SFN_Multiply,id:5298,x:32171,y:32590,varname:node_5298,prsc:2|A-4597-RGB,B-1353-OUT;n:type:ShaderForge.SFN_Clamp01,id:1353,x:32494,y:32845,varname:node_1353,prsc:2|IN-4425-OUT;n:type:ShaderForge.SFN_RemapRange,id:4425,x:32287,y:32845,varname:node_4425,prsc:2,frmn:0.45,frmx:0.5,tomn:0,tomx:1|IN-4069-G;n:type:ShaderForge.SFN_Multiply,id:6125,x:32621,y:33003,varname:node_6125,prsc:2|A-1353-OUT,B-8191-OUT;n:type:ShaderForge.SFN_ValueProperty,id:8191,x:32357,y:33119,ptovrint:False,ptlb:Opacity,ptin:_Opacity,varname:node_8191,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;proporder:6218-500-6528-5398-4597-8191;pass:END;sub:END;*/

Shader "ShaderLab/Lapis/Effect/SandClock2" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _ParticleSpeed ("ParticleSpeed", Range(-5, 5)) = -0.8281062
        _ShakeSpeed ("ShakeSpeed", Range(0, 1)) = 0
        _ShakeInt ("ShakeInt", Float ) = 0.03
        [HDR]_Color ("Color", Color) = (0.2696244,0.539391,0.6886792,1)
        _Opacity ("Opacity", Float ) = 1
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
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _ParticleSpeed;
            uniform float _ShakeSpeed;
            uniform float _ShakeInt;
            uniform float4 _Color;
            uniform float _Opacity;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
////// Emissive:
                float4 node_8981 = _Time;
                float U = i.uv0.r;
                float V = i.uv0.g;
                float Time = node_8981.g;
                float2 node_2125 = float2(U,(V+(Time*_ShakeSpeed)));
                float4 node_5289 = tex2D(_MainTex,TRANSFORM_TEX(node_2125, _MainTex));
                float2 node_2960 = (float2(i.uv0.r,(i.uv0.g+(node_8981.g*_ParticleSpeed)))+((node_5289.b*2.0+-1.0)*_ShakeInt));
                float4 node_4069 = tex2D(_MainTex,TRANSFORM_TEX(node_2960, _MainTex));
                float node_1353 = saturate((node_4069.g*20.0+-8.999998));
                float3 emissive = (_Color.rgb*node_1353);
                float3 finalColor = emissive;
                return fixed4(finalColor,(node_1353*_Opacity));
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
