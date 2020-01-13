// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32921,y:32720,varname:node_3138,prsc:2|emission-7216-OUT,alpha-7216-OUT;n:type:ShaderForge.SFN_TexCoord,id:8545,x:31376,y:32552,varname:node_8545,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Noise,id:6413,x:32496,y:32856,varname:node_6413,prsc:2|XY-9290-UVOUT;n:type:ShaderForge.SFN_Posterize,id:382,x:31952,y:32537,varname:node_382,prsc:2|IN-9333-OUT,STPS-1791-OUT;n:type:ShaderForge.SFN_Slider,id:1791,x:31777,y:32753,ptovrint:False,ptlb:Density,ptin:_Density,varname:node_4470,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:3,max:300;n:type:ShaderForge.SFN_Panner,id:9290,x:32508,y:32613,varname:node_9290,prsc:2,spu:0.1,spv:0.1|UVIN-382-OUT,DIST-2420-OUT;n:type:ShaderForge.SFN_Slider,id:5837,x:31713,y:32996,ptovrint:False,ptlb:SpeedNoise,ptin:_SpeedNoise,varname:node_1030,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:98.33076,max:100;n:type:ShaderForge.SFN_Time,id:1496,x:31870,y:32830,varname:node_1496,prsc:2;n:type:ShaderForge.SFN_Multiply,id:2420,x:32239,y:32797,varname:node_2420,prsc:2|A-1496-T,B-2906-OUT,C-8650-OUT;n:type:ShaderForge.SFN_Vector1,id:8650,x:32239,y:32991,varname:node_8650,prsc:2,v1:0.001;n:type:ShaderForge.SFN_RemapRange,id:9333,x:31630,y:32552,varname:node_9333,prsc:2,frmn:0,frmx:1,tomn:1,tomx:2|IN-8545-UVOUT;n:type:ShaderForge.SFN_RemapRange,id:2906,x:32040,y:33047,varname:node_2906,prsc:2,frmn:0,frmx:1,tomn:0,tomx:0.1|IN-5837-OUT;n:type:ShaderForge.SFN_Multiply,id:7216,x:32715,y:32978,varname:node_7216,prsc:2|A-6413-OUT,B-4666-OUT;n:type:ShaderForge.SFN_Slider,id:4666,x:32371,y:33193,ptovrint:False,ptlb:Opacity,ptin:_Opacity,varname:node_4666,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;proporder:1791-5837-4666;pass:END;sub:END;*/

Shader "Lapis/Effect/Noise" {
    Properties {
        _Density ("Density", Range(0, 300)) = 3
        _SpeedNoise ("SpeedNoise", Range(0, 100)) = 98.33076
        _Opacity ("Opacity", Range(0, 1)) = 1
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
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma target 3.0
            uniform float _Density;
            uniform float _SpeedNoise;
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
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float4 node_1496 = _Time;
                float2 node_9290 = (floor((i.uv0*1.0+1.0) * _Density) / (_Density - 1)+(node_1496.g*(_SpeedNoise*0.1+0.0)*0.001)*float2(0.1,0.1));
                float2 node_6413_skew = node_9290 + 0.2127+node_9290.x*0.3713*node_9290.y;
                float2 node_6413_rnd = 4.789*sin(489.123*(node_6413_skew));
                float node_6413 = frac(node_6413_rnd.x*node_6413_rnd.y*(1+node_6413_skew.x));
                float node_7216 = (node_6413*_Opacity);
                float3 emissive = float3(node_7216,node_7216,node_7216);
                float3 finalColor = emissive;
                return fixed4(finalColor,node_7216);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
