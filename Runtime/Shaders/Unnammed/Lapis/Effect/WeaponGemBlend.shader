// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33668,y:32717,varname:node_3138,prsc:2|custl-2987-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32093,y:33194,ptovrint:False,ptlb:Vein1 Color,ptin:_Vein1Color,varname:_Vein1Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.4,c2:0.3803922,c3:1,c4:1;n:type:ShaderForge.SFN_Tex2d,id:3588,x:32160,y:32839,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_TexCoord,id:8609,x:31706,y:33354,varname:node_8609,prsc:2,uv:1,uaff:False;n:type:ShaderForge.SFN_Append,id:3634,x:31484,y:33211,varname:node_3634,prsc:2|A-9043-X,B-9043-Y;n:type:ShaderForge.SFN_Multiply,id:7247,x:31702,y:33211,varname:node_7247,prsc:2|A-3634-OUT,B-4143-T;n:type:ShaderForge.SFN_Time,id:4143,x:31485,y:33375,varname:node_4143,prsc:2;n:type:ShaderForge.SFN_Add,id:1221,x:31919,y:33044,varname:node_1221,prsc:2|A-7247-OUT,B-8609-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:2706,x:32093,y:33044,varname:node_2706,prsc:2,ntxv:0,isnm:False|UVIN-1221-OUT,TEX-1926-TEX;n:type:ShaderForge.SFN_Multiply,id:5951,x:32546,y:32949,varname:node_5951,prsc:2|A-2706-R,B-7241-RGB,C-4942-X;n:type:ShaderForge.SFN_Multiply,id:2181,x:33050,y:32834,varname:node_2181,prsc:2|A-6313-OUT,B-3588-RGB;n:type:ShaderForge.SFN_ValueProperty,id:6313,x:32160,y:32752,ptovrint:False,ptlb:Opacticy,ptin:_Opacticy,varname:_Opacticy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Append,id:8788,x:31484,y:33534,varname:node_8788,prsc:2|A-9043-Z,B-9043-W;n:type:ShaderForge.SFN_Multiply,id:2791,x:31706,y:33544,varname:node_2791,prsc:2|A-4143-T,B-8788-OUT;n:type:ShaderForge.SFN_Tex2dAsset,id:1926,x:31915,y:33354,ptovrint:False,ptlb:Vein,ptin:_Vein,varname:_Vein,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:7978,x:32108,y:33564,varname:node_7978,prsc:2,ntxv:0,isnm:False|UVIN-1903-OUT,TEX-1926-TEX;n:type:ShaderForge.SFN_Add,id:1903,x:31915,y:33564,varname:node_1903,prsc:2|A-8609-UVOUT,B-2791-OUT;n:type:ShaderForge.SFN_Fresnel,id:7079,x:32091,y:33722,varname:node_7079,prsc:2|EXP-8099-OUT;n:type:ShaderForge.SFN_Slider,id:8099,x:31751,y:33741,ptovrint:False,ptlb:Vein2 Rank,ptin:_Vein2Rank,varname:_Vein2Rank,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:3;n:type:ShaderForge.SFN_Multiply,id:853,x:32378,y:33789,varname:node_853,prsc:2|A-7978-B,B-7079-OUT,C-6441-RGB,D-4942-Y;n:type:ShaderForge.SFN_Color,id:6441,x:32091,y:33874,ptovrint:False,ptlb:Vein2 Color,ptin:_Vein2Color,varname:_Vein2Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.07843138,c2:0.3921569,c3:0.7843137,c4:1;n:type:ShaderForge.SFN_Add,id:2987,x:33292,y:32957,varname:node_2987,prsc:2|A-5951-OUT,B-853-OUT,C-2825-OUT,D-2181-OUT;n:type:ShaderForge.SFN_Tex2d,id:5919,x:32091,y:34155,varname:node_5919,prsc:2,ntxv:0,isnm:False|UVIN-5602-OUT,TEX-1926-TEX;n:type:ShaderForge.SFN_Append,id:5474,x:31394,y:34097,varname:node_5474,prsc:2|A-1485-X,B-1485-Y;n:type:ShaderForge.SFN_Multiply,id:4898,x:31644,y:34085,varname:node_4898,prsc:2|A-4143-T,B-5474-OUT;n:type:ShaderForge.SFN_Add,id:4465,x:31851,y:34065,varname:node_4465,prsc:2|A-8609-UVOUT,B-4898-OUT;n:type:ShaderForge.SFN_Multiply,id:2825,x:32550,y:34150,varname:node_2825,prsc:2|A-5919-G,B-4942-Z,C-1327-RGB,D-8898-OUT;n:type:ShaderForge.SFN_Fresnel,id:6017,x:32091,y:34544,varname:node_6017,prsc:2|EXP-8784-OUT;n:type:ShaderForge.SFN_Slider,id:8784,x:31687,y:34567,ptovrint:False,ptlb:Vein3 Rank,ptin:_Vein3Rank,varname:_Vein3Rank,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_OneMinus,id:8898,x:32291,y:34544,varname:node_8898,prsc:2|IN-6017-OUT;n:type:ShaderForge.SFN_Color,id:1327,x:32091,y:34388,ptovrint:False,ptlb:Vein3 Color,ptin:_Vein3Color,varname:_Vein3Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:5602,x:31912,y:34206,varname:node_5602,prsc:2|A-4465-OUT,B-4668-OUT;n:type:ShaderForge.SFN_Append,id:4668,x:31752,y:34299,varname:node_4668,prsc:2|A-1485-Z,B-1485-W;n:type:ShaderForge.SFN_Vector4Property,id:9043,x:30934,y:33274,ptovrint:False,ptlb:Vein&Vein2 Speed,ptin:_VeinVein2Speed,varname:node_9043,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0,v2:0,v3:0,v4:0;n:type:ShaderForge.SFN_Vector4Property,id:1485,x:30895,y:34000,ptovrint:False,ptlb:Vein3 Speed&Tiling,ptin:_Vein3SpeedTiling,varname:node_1485,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0,v2:0,v3:0,v4:0;n:type:ShaderForge.SFN_Vector4Property,id:4942,x:32294,y:34029,ptovrint:False,ptlb:Vein Intensity,ptin:_VeinIntensity,varname:node_4942,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0,v2:0,v3:0,v4:0;proporder:3588-1926-9043-4942-1485-7241-6441-1327-8099-8784-6313;pass:END;sub:END;*/

Shader "Lapis/Effect/WeaponGemBlend" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _Vein ("Vein", 2D) = "white" {}
        _VeinVein2Speed ("Vein&Vein2 Speed", Vector) = (0,0,0,0)
        _VeinIntensity ("Vein Intensity", Vector) = (0,0,0,0)
        _Vein3SpeedTiling ("Vein3 Speed&Tiling", Vector) = (0,0,0,0)
        [HDR]_Vein1Color ("Vein1 Color", Color) = (0.4,0.3803922,1,1)
        [HDR]_Vein2Color ("Vein2 Color", Color) = (0.07843138,0.3921569,0.7843137,1)
        [HDR]_Vein3Color ("Vein3 Color", Color) = (0.5,0.5,0.5,1)
        _Vein2Rank ("Vein2 Rank", Range(0, 3)) = 0
        _Vein3Rank ("Vein3 Rank", Range(0, 1)) = 0
        _Opacticy ("Opacticy", Float ) = 1
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
            Blend SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma target 3.0
            uniform float4 _Vein1Color;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Opacticy;
            uniform sampler2D _Vein; uniform float4 _Vein_ST;
            uniform float _Vein2Rank;
            uniform float4 _Vein2Color;
            uniform float _Vein3Rank;
            uniform float4 _Vein3Color;
            uniform float4 _VeinVein2Speed;
            uniform float4 _Vein3SpeedTiling;
            uniform float4 _VeinIntensity;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
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
                float4 node_4143 = _Time;
                float2 node_1221 = ((float2(_VeinVein2Speed.r,_VeinVein2Speed.g)*node_4143.g)+i.uv1);
                float4 node_2706 = tex2D(_Vein,TRANSFORM_TEX(node_1221, _Vein));
                float2 node_1903 = (i.uv1+(node_4143.g*float2(_VeinVein2Speed.b,_VeinVein2Speed.a)));
                float4 node_7978 = tex2D(_Vein,TRANSFORM_TEX(node_1903, _Vein));
                float2 node_5602 = ((i.uv1+(node_4143.g*float2(_Vein3SpeedTiling.r,_Vein3SpeedTiling.g)))*float2(_Vein3SpeedTiling.b,_Vein3SpeedTiling.a));
                float4 node_5919 = tex2D(_Vein,TRANSFORM_TEX(node_5602, _Vein));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 finalColor = ((node_2706.r*_Vein1Color.rgb*_VeinIntensity.r)+(node_7978.b*pow(1.0-max(0,dot(normalDirection, viewDirection)),_Vein2Rank)*_Vein2Color.rgb*_VeinIntensity.g)+(node_5919.g*_VeinIntensity.b*_Vein3Color.rgb*(1.0 - pow(1.0-max(0,dot(normalDirection, viewDirection)),_Vein3Rank)))+(_Opacticy*_MainTex_var.rgb));
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
