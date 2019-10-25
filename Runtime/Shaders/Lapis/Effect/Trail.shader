// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:34533,y:33054,varname:node_9361,prsc:2|emission-9317-OUT,alpha-7301-OUT;n:type:ShaderForge.SFN_Slider,id:7047,x:32285,y:33223,ptovrint:False,ptlb:Length,ptin:_Length,varname:_Legth,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1.016233,max:2;n:type:ShaderForge.SFN_Multiply,id:2378,x:32711,y:33159,varname:node_2378,prsc:2|A-1964-OUT,B-7047-OUT;n:type:ShaderForge.SFN_TexCoord,id:3604,x:31542,y:33251,varname:node_3604,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Tex2d,id:828,x:31937,y:32940,ptovrint:False,ptlb:DissTex,ptin:_DissTex,varname:_DissTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-9274-UVOUT;n:type:ShaderForge.SFN_Add,id:8755,x:32190,y:33332,varname:node_8755,prsc:2|A-828-G,B-1822-OUT;n:type:ShaderForge.SFN_OneMinus,id:6486,x:31748,y:33344,varname:node_6486,prsc:2|IN-3604-U;n:type:ShaderForge.SFN_ConstantClamp,id:1822,x:31955,y:33344,varname:node_1822,prsc:2,min:0.25,max:0.75|IN-6486-OUT;n:type:ShaderForge.SFN_Subtract,id:6452,x:32889,y:33332,varname:node_6452,prsc:2|A-8755-OUT,B-2378-OUT;n:type:ShaderForge.SFN_ComponentMask,id:6115,x:32175,y:32940,varname:node_6115,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-828-RGB;n:type:ShaderForge.SFN_Multiply,id:1463,x:32660,y:32935,varname:node_1463,prsc:2|A-6115-OUT,B-5180-OUT,C-1964-OUT;n:type:ShaderForge.SFN_Slider,id:5180,x:32285,y:33039,ptovrint:False,ptlb:Dissolove,ptin:_Dissolove,varname:_Dissolove,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.6065434,max:1;n:type:ShaderForge.SFN_Add,id:2514,x:33002,y:32918,varname:node_2514,prsc:2|A-6324-OUT,B-1463-OUT,C-9563-OUT;n:type:ShaderForge.SFN_Tex2d,id:3096,x:33200,y:32918,ptovrint:False,ptlb:VeinTex,ptin:_VeinTex,varname:_VeinTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-2514-OUT;n:type:ShaderForge.SFN_Multiply,id:3262,x:33204,y:33203,varname:node_3262,prsc:2|A-6452-OUT,B-3096-A;n:type:ShaderForge.SFN_Color,id:4267,x:33606,y:32424,ptovrint:False,ptlb:ColorStart,ptin:_ColorStart,varname:_ColorStart,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5148315,c2:0.1635368,c3:0.990566,c4:1;n:type:ShaderForge.SFN_Color,id:8070,x:33606,y:32578,ptovrint:False,ptlb:ColorEnd,ptin:_ColorEnd,varname:_ColorEnd,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.8571095,c2:0.2392157,c3:1,c4:1;n:type:ShaderForge.SFN_Lerp,id:6067,x:33810,y:32653,varname:node_6067,prsc:2|A-4267-RGB,B-8070-RGB,T-451-OUT;n:type:ShaderForge.SFN_Multiply,id:9317,x:33588,y:33136,varname:node_9317,prsc:2|A-6067-OUT,B-3262-OUT;n:type:ShaderForge.SFN_Multiply,id:451,x:33606,y:32727,varname:node_451,prsc:2|A-9460-OUT,B-9807-OUT;n:type:ShaderForge.SFN_Slider,id:9807,x:33226,y:32746,ptovrint:False,ptlb:ColorClamp,ptin:_ColorClamp,varname:_ColorClamp,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:3;n:type:ShaderForge.SFN_Set,id:9231,x:31748,y:33269,varname:U,prsc:2|IN-3604-U;n:type:ShaderForge.SFN_Get,id:1964,x:32471,y:33145,varname:node_1964,prsc:2|IN-9231-OUT;n:type:ShaderForge.SFN_Get,id:9460,x:33337,y:32673,varname:node_9460,prsc:2|IN-9231-OUT;n:type:ShaderForge.SFN_Set,id:853,x:31748,y:33205,varname:UV,prsc:2|IN-3604-UVOUT;n:type:ShaderForge.SFN_Get,id:6324,x:32800,y:32691,varname:node_6324,prsc:2|IN-853-OUT;n:type:ShaderForge.SFN_ValueProperty,id:9495,x:32465,y:32565,ptovrint:False,ptlb:USpeed,ptin:_USpeed,varname:node_9495,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:-1;n:type:ShaderForge.SFN_ValueProperty,id:7911,x:32465,y:32646,ptovrint:False,ptlb:VSpeed,ptin:_VSpeed,varname:node_7911,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Append,id:7307,x:32640,y:32587,varname:node_7307,prsc:2|A-9495-OUT,B-7911-OUT;n:type:ShaderForge.SFN_Time,id:2435,x:32640,y:32456,varname:node_2435,prsc:2;n:type:ShaderForge.SFN_Multiply,id:9563,x:32811,y:32544,varname:node_9563,prsc:2|A-2435-T,B-7307-OUT;n:type:ShaderForge.SFN_Panner,id:9274,x:31759,y:33040,varname:node_9274,prsc:2,spu:-1,spv:0|UVIN-3604-UVOUT;n:type:ShaderForge.SFN_VertexColor,id:9538,x:33348,y:33494,varname:node_9538,prsc:2;n:type:ShaderForge.SFN_Multiply,id:7301,x:33575,y:33415,varname:node_7301,prsc:2|A-3262-OUT,B-9538-A,C-5141-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5141,x:33479,y:33726,ptovrint:False,ptlb:Opacity,ptin:_Opacity,varname:node_5141,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;proporder:7047-828-5180-3096-4267-8070-9807-9495-7911-5141;pass:END;sub:END;*/

Shader "ShaderLab/Lapis/Effect/Trail" {
    Properties {
        _Length ("Length", Range(0, 2)) = 1.016233
        _DissTex ("DissTex", 2D) = "white" {}
        _Dissolove ("Dissolove", Range(0, 1)) = 0.6065434
        _VeinTex ("VeinTex", 2D) = "white" {}
        [HDR]_ColorStart ("ColorStart", Color) = (0.5148315,0.1635368,0.990566,1)
        [HDR]_ColorEnd ("ColorEnd", Color) = (0.8571095,0.2392157,1,1)
        _ColorClamp ("ColorClamp", Range(0, 3)) = 1
        _USpeed ("USpeed", Float ) = -1
        _VSpeed ("VSpeed", Float ) = 0
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
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float _Length;
            uniform sampler2D _DissTex; uniform float4 _DissTex_ST;
            uniform float _Dissolove;
            uniform sampler2D _VeinTex; uniform float4 _VeinTex_ST;
            uniform float4 _ColorStart;
            uniform float4 _ColorEnd;
            uniform float _ColorClamp;
            uniform float _USpeed;
            uniform float _VSpeed;
            uniform float _Opacity;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 vertexColor : COLOR;
                UNITY_FOG_COORDS(1)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
////// Emissive:
                float U = i.uv0.r;
                float4 node_2208 = _Time;
                float2 node_9274 = (i.uv0+node_2208.g*float2(-1,0));
                float4 _DissTex_var = tex2D(_DissTex,TRANSFORM_TEX(node_9274, _DissTex));
                float node_1964 = U;
                float2 UV = i.uv0;
                float4 node_2435 = _Time;
                float2 node_2514 = (UV+(_DissTex_var.rgb.rg*_Dissolove*node_1964)+(node_2435.g*float2(_USpeed,_VSpeed)));
                float4 _VeinTex_var = tex2D(_VeinTex,TRANSFORM_TEX(node_2514, _VeinTex));
                float node_3262 = (((_DissTex_var.g+clamp((1.0 - i.uv0.r),0.25,0.75))-(node_1964*_Length))*_VeinTex_var.a);
                float3 emissive = (lerp(_ColorStart.rgb,_ColorEnd.rgb,(U*_ColorClamp))*node_3262);
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,(node_3262*i.vertexColor.a*_Opacity));
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
