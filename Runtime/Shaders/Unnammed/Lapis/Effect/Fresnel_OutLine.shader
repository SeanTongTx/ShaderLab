// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32718,y:32801,varname:node_3138,prsc:2|emission-5591-OUT,olwid-855-OUT,olcol-4449-RGB;n:type:ShaderForge.SFN_Color,id:7241,x:32060,y:32753,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.745283,c2:0.745283,c3:0.745283,c4:1;n:type:ShaderForge.SFN_Multiply,id:8343,x:32312,y:32896,varname:node_8343,prsc:2|A-7241-RGB,B-7712-RGB;n:type:ShaderForge.SFN_Tex2d,id:7712,x:32060,y:32926,ptovrint:False,ptlb:MainTexture,ptin:_MainTexture,varname:node_7712,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:378a83beb32b6b54fa0e121cbc5b4e76,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:855,x:32051,y:33117,ptovrint:False,ptlb:OutLine Width,ptin:_OutLineWidth,varname:node_855,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.03931624,max:0.2;n:type:ShaderForge.SFN_Color,id:4449,x:32051,y:33219,ptovrint:False,ptlb:OutLine Color,ptin:_OutLineColor,varname:node_4449,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Fresnel,id:7450,x:32045,y:32554,varname:node_7450,prsc:2|EXP-5740-OUT;n:type:ShaderForge.SFN_Slider,id:5740,x:31523,y:32661,ptovrint:False,ptlb:Fresnel Intensity,ptin:_FresnelIntensity,varname:node_5740,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:2;n:type:ShaderForge.SFN_Add,id:5591,x:32462,y:32711,varname:node_5591,prsc:2|A-449-OUT,B-8343-OUT;n:type:ShaderForge.SFN_Multiply,id:449,x:32059,y:32406,varname:node_449,prsc:2|A-9831-RGB,B-7450-OUT;n:type:ShaderForge.SFN_Color,id:9831,x:31648,y:32408,ptovrint:False,ptlb:Fresnel Color,ptin:_FresnelColor,varname:node_9831,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:7712-7241-5740-9831-855-4449;pass:END;sub:END;*/

Shader "Lapis/Effect/Fresnel_OutLine" {
    Properties {
        _MainTexture ("MainTexture", 2D) = "white" {}
        _Color ("Color", Color) = (0.745283,0.745283,0.745283,1)
        _FresnelIntensity ("Fresnel Intensity", Range(0, 2)) = 1
        _FresnelColor ("Fresnel Color", Color) = (0.5,0.5,0.5,1)
        _OutLineWidth ("OutLine Width", Range(0, 0.2)) = 0.03931624
        [HDR]_OutLineColor ("OutLine Color", Color) = (1,1,1,1)
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "Outline"
            Tags {
            }
            Cull Front
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma target 3.0
            uniform float _OutLineWidth;
            uniform float4 _OutLineColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.normal*_OutLineWidth,1) );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                return fixed4(_OutLineColor.rgb,0);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _MainTexture; uniform float4 _MainTexture_ST;
            uniform float _FresnelIntensity;
            uniform float4 _FresnelColor;
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
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float4 _MainTexture_var = tex2D(_MainTexture,TRANSFORM_TEX(i.uv0, _MainTexture));
                float3 emissive = ((_FresnelColor.rgb*pow(1.0-max(0,dot(normalDirection, viewDirection)),_FresnelIntensity))+(_Color.rgb*_MainTexture_var.rgb));
                float3 finalColor = emissive;
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
	Fallback "Hidden/Lapis/VertexLit"
    CustomEditor "ShaderForgeMaterialInspector"
}
