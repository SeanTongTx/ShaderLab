// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:False,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4013,x:33335,y:32847,varname:node_4013,prsc:2|emission-7867-RGB,custl-5159-OUT;n:type:ShaderForge.SFN_Tex2d,id:7867,x:32712,y:32869,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_7867,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Time,id:1128,x:32042,y:33158,varname:node_1128,prsc:2;n:type:ShaderForge.SFN_Append,id:7331,x:32042,y:33319,varname:node_7331,prsc:2|A-981-OUT,B-5281-OUT;n:type:ShaderForge.SFN_ValueProperty,id:981,x:31845,y:33319,ptovrint:False,ptlb:Vein U Speed,ptin:_VeinUSpeed,varname:_USpeed_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:5281,x:31845,y:33393,ptovrint:False,ptlb:Vein V Speed,ptin:_VeinVSpeed,varname:_VSpeed_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:7072,x:32236,y:33248,varname:node_7072,prsc:2|A-1128-T,B-7331-OUT;n:type:ShaderForge.SFN_Add,id:8379,x:32498,y:33107,varname:node_8379,prsc:2|A-3423-UVOUT,B-7072-OUT;n:type:ShaderForge.SFN_Tex2d,id:2930,x:32712,y:33060,ptovrint:False,ptlb:VeinTex,ptin:_VeinTex,varname:node_2930,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-8379-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6763,x:32712,y:33261,ptovrint:False,ptlb:VeinInt,ptin:_VeinInt,varname:node_6763,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:5159,x:33024,y:33110,varname:node_5159,prsc:2|A-2930-RGB,B-6763-OUT,C-2010-RGB,D-7867-A;n:type:ShaderForge.SFN_Color,id:2010,x:32700,y:33357,ptovrint:False,ptlb:VeinColor,ptin:_VeinColor,varname:node_2010,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_ScreenPos,id:3423,x:32236,y:33043,varname:node_3423,prsc:2,sctp:1;proporder:7867-981-5281-2930-6763-2010;pass:END;sub:END;*/

Shader "Lapis/Effect/ScreenUv" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _VeinUSpeed ("Vein U Speed", Float ) = 0
        _VeinVSpeed ("Vein V Speed", Float ) = 0
        _VeinTex ("VeinTex", 2D) = "white" {}
        _VeinInt ("VeinInt", Float ) = 0
        [HDR]_VeinColor ("VeinColor", Color) = (0.5,0.5,0.5,1)
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _VeinUSpeed;
            uniform float _VeinVSpeed;
            uniform sampler2D _VeinTex; uniform float4 _VeinTex_ST;
            uniform float _VeinInt;
            uniform float4 _VeinColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 projPos : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
////// Lighting:
////// Emissive:
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 emissive = _MainTex_var.rgb;
                float4 node_1128 = _Time;
                float2 node_8379 = (float2((sceneUVs.x * 2 - 1)*(_ScreenParams.r/_ScreenParams.g), sceneUVs.y * 2 - 1).rg+(node_1128.g*float2(_VeinUSpeed,_VeinVSpeed)));
                float4 _VeinTex_var = tex2D(_VeinTex,TRANSFORM_TEX(node_8379, _VeinTex));
                float3 finalColor = emissive + (_VeinTex_var.rgb*_VeinInt*_VeinColor.rgb*_MainTex_var.a);
                return fixed4(finalColor,1);
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
