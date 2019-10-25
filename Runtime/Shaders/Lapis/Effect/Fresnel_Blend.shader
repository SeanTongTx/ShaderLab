// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32709,y:32968,varname:node_3138,prsc:2|emission-1727-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:31907,y:32801,ptovrint:False,ptlb:Outline Color,ptin:_OutlineColor,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.8632076,c2:0.9240042,c3:1,c4:1;n:type:ShaderForge.SFN_Fresnel,id:3464,x:31907,y:32955,varname:node_3464,prsc:2|EXP-8723-OUT;n:type:ShaderForge.SFN_Slider,id:8723,x:31570,y:32974,ptovrint:False,ptlb:Rank,ptin:_Rank,varname:node_8723,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:2.393162,max:5;n:type:ShaderForge.SFN_Multiply,id:3024,x:32120,y:32933,varname:node_3024,prsc:2|A-7241-RGB,B-3464-OUT;n:type:ShaderForge.SFN_Tex2d,id:5739,x:31909,y:33131,ptovrint:False,ptlb:Texture,ptin:_Texture,varname:node_5739,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Color,id:362,x:31909,y:33308,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_362,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:8518,x:32119,y:33225,varname:node_8518,prsc:2|A-5739-RGB,B-362-RGB,C-2101-OUT;n:type:ShaderForge.SFN_Add,id:9947,x:32382,y:33068,varname:node_9947,prsc:2|A-3024-OUT,B-8518-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2101,x:31909,y:33475,ptovrint:False,ptlb:Itensity,ptin:_Itensity,varname:node_2101,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Multiply,id:1727,x:32514,y:33211,varname:node_1727,prsc:2|A-9947-OUT,B-2101-OUT;proporder:5739-362-7241-8723-2101;pass:END;sub:END;*/

Shader "ShaderLab/Lapis/Effect/Fresnel_Blend" {
    Properties {
        _Texture ("Texture", 2D) = "white" {}
        [HDR]_Color ("Color", Color) = (0.5,0.5,0.5,1)
        [HDR]_OutlineColor ("Outline Color", Color) = (0.8632076,0.9240042,1,1)
        _Rank ("Rank", Range(0, 5)) = 2.393162
        _Itensity ("Itensity", Float ) = 1
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Blend One One
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma target 3.0
            uniform float4 _OutlineColor;
            uniform float _Rank;
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
            uniform float4 _Color;
            uniform float _Itensity;
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
                float4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(i.uv0, _Texture));
                float3 emissive = (((_OutlineColor.rgb*pow(1.0-max(0,dot(normalDirection, viewDirection)),_Rank))+(_Texture_var.rgb*_Color.rgb*_Itensity))*_Itensity);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
