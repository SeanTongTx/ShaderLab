// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33638,y:32847,varname:node_3138,prsc:2|emission-9499-OUT,alpha-7857-OUT,refract-3419-OUT;n:type:ShaderForge.SFN_Tex2d,id:5091,x:32810,y:33320,ptovrint:False,ptlb:Normal,ptin:_Normal,varname:node_5091,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:1da962c1d551c974f987583152a3b222,ntxv:0,isnm:False|UVIN-560-OUT;n:type:ShaderForge.SFN_Tex2d,id:4312,x:32503,y:32978,ptovrint:False,ptlb:Texture,ptin:_Texture,varname:node_4312,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:edbc58dd2c43d7249839ce382ed094dd,ntxv:0,isnm:False|UVIN-4481-OUT;n:type:ShaderForge.SFN_Color,id:1014,x:32397,y:32698,ptovrint:False,ptlb:color,ptin:_color,varname:node_1014,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:0.5;n:type:ShaderForge.SFN_Multiply,id:9499,x:33051,y:32826,varname:node_9499,prsc:2|A-1014-RGB,B-4312-RGB,C-1249-RGB;n:type:ShaderForge.SFN_Multiply,id:4986,x:33051,y:32991,varname:node_4986,prsc:2|A-1014-A,B-4312-A,C-1249-A;n:type:ShaderForge.SFN_Tex2d,id:1894,x:31699,y:33217,ptovrint:False,ptlb:Noise01,ptin:_Noise01,varname:node_1894,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:206527f8661637a40acffb31ee443ce2,ntxv:0,isnm:False|UVIN-9856-OUT;n:type:ShaderForge.SFN_Tex2d,id:9252,x:31699,y:33405,ptovrint:False,ptlb:Noise02,ptin:_Noise02,varname:node_9252,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:206527f8661637a40acffb31ee443ce2,ntxv:0,isnm:False|UVIN-4776-OUT;n:type:ShaderForge.SFN_TexCoord,id:2836,x:30956,y:32998,varname:node_2836,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:7700,x:31304,y:33392,varname:node_7700,prsc:2|A-3282-T,B-3614-OUT;n:type:ShaderForge.SFN_Time,id:3282,x:30933,y:33282,varname:node_3282,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:9332,x:30925,y:33479,ptovrint:False,ptlb:Noise01USpeed,ptin:_Noise01USpeed,varname:node_9332,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:7466,x:30925,y:33566,ptovrint:False,ptlb:Noise01VSpeed,ptin:_Noise01VSpeed,varname:node_7466,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Append,id:3614,x:31129,y:33522,varname:node_3614,prsc:2|A-9332-OUT,B-7466-OUT;n:type:ShaderForge.SFN_Add,id:9856,x:31489,y:33259,varname:node_9856,prsc:2|A-2836-UVOUT,B-7700-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6811,x:30928,y:33717,ptovrint:False,ptlb:Noise02USpeed,ptin:_Noise02USpeed,varname:node_6811,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:-1;n:type:ShaderForge.SFN_ValueProperty,id:5306,x:30928,y:33818,ptovrint:False,ptlb:Noise02VSpeed,ptin:_Noise02VSpeed,varname:node_5306,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Append,id:2393,x:31183,y:33734,varname:node_2393,prsc:2|A-6811-OUT,B-5306-OUT;n:type:ShaderForge.SFN_Multiply,id:9036,x:31386,y:33646,varname:node_9036,prsc:2|A-3282-T,B-2393-OUT;n:type:ShaderForge.SFN_Add,id:4776,x:31519,y:33493,varname:node_4776,prsc:2|A-2836-UVOUT,B-9036-OUT;n:type:ShaderForge.SFN_Multiply,id:6518,x:31908,y:33312,varname:node_6518,prsc:2|A-1894-RGB,B-9252-RGB,C-4260-OUT;n:type:ShaderForge.SFN_ComponentMask,id:1427,x:32238,y:33306,varname:node_1427,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-6518-OUT;n:type:ShaderForge.SFN_TexCoord,id:1294,x:32029,y:32850,varname:node_1294,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:4481,x:32426,y:33274,varname:node_4481,prsc:2|A-1294-UVOUT,B-1427-OUT;n:type:ShaderForge.SFN_ComponentMask,id:3419,x:33178,y:33225,varname:node_3419,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-7916-OUT;n:type:ShaderForge.SFN_Append,id:7079,x:31934,y:33855,varname:node_7079,prsc:2|A-17-OUT,B-2534-OUT;n:type:ShaderForge.SFN_ValueProperty,id:17,x:31729,y:33855,ptovrint:False,ptlb:NormalUSpeed,ptin:_NormalUSpeed,varname:node_17,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:2534,x:31729,y:33966,ptovrint:False,ptlb:NormalVSpeed,ptin:_NormalVSpeed,varname:node_2534,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Multiply,id:2715,x:32204,y:33733,varname:node_2715,prsc:2|A-3282-T,B-7079-OUT;n:type:ShaderForge.SFN_Add,id:560,x:32592,y:33407,varname:node_560,prsc:2|A-4481-OUT,B-2715-OUT;n:type:ShaderForge.SFN_ValueProperty,id:4260,x:32013,y:33605,ptovrint:False,ptlb:NoiseIntensity,ptin:_NoiseIntensity,varname:node_4260,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Multiply,id:7916,x:32999,y:33473,varname:node_7916,prsc:2|A-5091-RGB,B-7865-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7865,x:32786,y:33655,ptovrint:False,ptlb:NormalIntensity,ptin:_NormalIntensity,varname:node_7865,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5;n:type:ShaderForge.SFN_VertexColor,id:1249,x:32648,y:33137,varname:node_1249,prsc:2;n:type:ShaderForge.SFN_Clamp01,id:7857,x:33288,y:33040,varname:node_7857,prsc:2|IN-4986-OUT;proporder:1014-4312-1894-9252-4260-9332-7466-6811-5306-5091-7865-17-2534;pass:END;sub:END;*/

Shader "Lapis/Effect/WaterfallNormal" {
    Properties {
        [HDR]_color ("color", Color) = (0.5,0.5,0.5,0.5)
        _Texture ("Texture", 2D) = "white" {}
        _Noise01 ("Noise01", 2D) = "white" {}
        _Noise02 ("Noise02", 2D) = "white" {}
        _NoiseIntensity ("NoiseIntensity", Float ) = 1
        _Noise01USpeed ("Noise01USpeed", Float ) = 1
        _Noise01VSpeed ("Noise01VSpeed", Float ) = 1
        _Noise02USpeed ("Noise02USpeed", Float ) = -1
        _Noise02VSpeed ("Noise02VSpeed", Float ) = 1
        _Normal ("Normal", 2D) = "white" {}
        _NormalIntensity ("NormalIntensity", Float ) = 0.5
        _NormalUSpeed ("NormalUSpeed", Float ) = 0
        _NormalVSpeed ("NormalVSpeed", Float ) = 1
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        GrabPass{ }
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
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            //#pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _GrabTexture;
            uniform sampler2D _Normal; uniform float4 _Normal_ST;
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
            uniform float4 _color;
            uniform sampler2D _Noise01; uniform float4 _Noise01_ST;
            uniform sampler2D _Noise02; uniform float4 _Noise02_ST;
            uniform float _Noise01USpeed;
            uniform float _Noise01VSpeed;
            uniform float _Noise02USpeed;
            uniform float _Noise02VSpeed;
            uniform float _NormalUSpeed;
            uniform float _NormalVSpeed;
            uniform float _NoiseIntensity;
            uniform float _NormalIntensity;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 vertexColor : COLOR;
                float4 projPos : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float4 node_3282 = _Time;
                float2 node_9856 = (i.uv0+(node_3282.g*float2(_Noise01USpeed,_Noise01VSpeed)));
                float4 _Noise01_var = tex2D(_Noise01,TRANSFORM_TEX(node_9856, _Noise01));
                float2 node_4776 = (i.uv0+(node_3282.g*float2(_Noise02USpeed,_Noise02VSpeed)));
                float4 _Noise02_var = tex2D(_Noise02,TRANSFORM_TEX(node_4776, _Noise02));
                float2 node_4481 = (i.uv0+(_Noise01_var.rgb*_Noise02_var.rgb*_NoiseIntensity).rg);
                float2 node_560 = (node_4481+(node_3282.g*float2(_NormalUSpeed,_NormalVSpeed)));
                float4 _Normal_var = tex2D(_Normal,TRANSFORM_TEX(node_560, _Normal));
                float2 sceneUVs = (i.projPos.xy / i.projPos.w) + (_Normal_var.rgb*_NormalIntensity).rg;
                float4 sceneColor = tex2D(_GrabTexture, sceneUVs);
////// Lighting:
////// Emissive:
                float4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(node_4481, _Texture));
                float3 emissive = (_color.rgb*_Texture_var.rgb*i.vertexColor.rgb);
                float3 finalColor = emissive;
                return fixed4(lerp(sceneColor.rgb, finalColor,saturate((_color.a*_Texture_var.a*i.vertexColor.a))),1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
