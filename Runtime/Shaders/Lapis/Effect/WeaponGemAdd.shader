// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33668,y:32717,varname:node_3138,prsc:2|custl-2987-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32093,y:33194,ptovrint:False,ptlb:Vein1 Color,ptin:_Vein1Color,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.4,c2:0.3803922,c3:1,c4:1;n:type:ShaderForge.SFN_Tex2d,id:3588,x:32160,y:32839,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_3588,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:99785bd457949ac49afef7b0e07bf50c,ntxv:0,isnm:False;n:type:ShaderForge.SFN_TexCoord,id:8609,x:31706,y:33354,varname:node_8609,prsc:2,uv:1,uaff:False;n:type:ShaderForge.SFN_ValueProperty,id:2993,x:31226,y:33299,ptovrint:False,ptlb:Vein1 Roll Y,ptin:_Vein1RollY,varname:node_2993,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.12;n:type:ShaderForge.SFN_ValueProperty,id:3193,x:31226,y:33189,ptovrint:False,ptlb:Vein1 Roll X,ptin:_Vein1RollX,varname:node_3193,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.17;n:type:ShaderForge.SFN_Append,id:3634,x:31484,y:33211,varname:node_3634,prsc:2|A-3193-OUT,B-2993-OUT;n:type:ShaderForge.SFN_Multiply,id:7247,x:31702,y:33211,varname:node_7247,prsc:2|A-3634-OUT,B-4143-T;n:type:ShaderForge.SFN_Time,id:4143,x:31484,y:33375,varname:node_4143,prsc:2;n:type:ShaderForge.SFN_Add,id:1221,x:31919,y:33044,varname:node_1221,prsc:2|A-7247-OUT,B-8609-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:2706,x:32093,y:33044,varname:node_2706,prsc:2,tex:98ea46c8f3e32074fa40ba1e0b126fd8,ntxv:0,isnm:False|UVIN-1221-OUT,TEX-1926-TEX;n:type:ShaderForge.SFN_Multiply,id:5951,x:32546,y:32949,varname:node_5951,prsc:2|A-2706-R,B-7241-RGB,C-8927-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5141,x:32093,y:33354,ptovrint:False,ptlb:Vein1 Intensity,ptin:_Vein1Intensity,varname:node_5141,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1.49;n:type:ShaderForge.SFN_Multiply,id:2181,x:33050,y:32834,varname:node_2181,prsc:2|A-6313-OUT,B-3588-RGB;n:type:ShaderForge.SFN_ValueProperty,id:6313,x:32160,y:32752,ptovrint:False,ptlb:Opacticy,ptin:_Opacticy,varname:node_6313,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:7710,x:31226,y:33507,ptovrint:False,ptlb:Vein2 Roll X,ptin:_Vein2RollX,varname:node_7710,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.1;n:type:ShaderForge.SFN_ValueProperty,id:1066,x:31226,y:33608,ptovrint:False,ptlb:Vein2 Roll Y,ptin:_Vein2RollY,varname:node_1066,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.1;n:type:ShaderForge.SFN_Append,id:8788,x:31484,y:33534,varname:node_8788,prsc:2|A-7710-OUT,B-1066-OUT;n:type:ShaderForge.SFN_Multiply,id:2791,x:31706,y:33544,varname:node_2791,prsc:2|A-4143-T,B-8788-OUT;n:type:ShaderForge.SFN_Tex2dAsset,id:1926,x:31915,y:33354,ptovrint:False,ptlb:Vein,ptin:_Vein,varname:node_1926,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:98ea46c8f3e32074fa40ba1e0b126fd8,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:7978,x:32108,y:33564,varname:node_7978,prsc:2,tex:98ea46c8f3e32074fa40ba1e0b126fd8,ntxv:0,isnm:False|UVIN-1903-OUT,TEX-1926-TEX;n:type:ShaderForge.SFN_Add,id:1903,x:31915,y:33564,varname:node_1903,prsc:2|A-8609-UVOUT,B-2791-OUT;n:type:ShaderForge.SFN_Fresnel,id:7079,x:32091,y:33722,varname:node_7079,prsc:2|EXP-8099-OUT;n:type:ShaderForge.SFN_Slider,id:8099,x:31751,y:33741,ptovrint:False,ptlb:Vein2 Rank,ptin:_Vein2Rank,varname:node_8099,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:3;n:type:ShaderForge.SFN_Multiply,id:853,x:32378,y:33789,varname:node_853,prsc:2|A-7978-B,B-7079-OUT,C-6441-RGB,D-5520-OUT;n:type:ShaderForge.SFN_Color,id:6441,x:32091,y:33874,ptovrint:False,ptlb:Vein2 Color,ptin:_Vein2Color,varname:node_6441,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.07843138,c2:0.3921569,c3:0.7843137,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:5520,x:32091,y:34050,ptovrint:False,ptlb:Vein2 Intensity,ptin:_Vein2Intensity,varname:node_5520,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.91;n:type:ShaderForge.SFN_Add,id:2987,x:33292,y:32957,varname:node_2987,prsc:2|A-5951-OUT,B-853-OUT,C-2825-OUT,D-2181-OUT;n:type:ShaderForge.SFN_Tex2d,id:5919,x:32091,y:34155,varname:node_5919,prsc:2,tex:98ea46c8f3e32074fa40ba1e0b126fd8,ntxv:0,isnm:False|UVIN-5602-OUT,TEX-1926-TEX;n:type:ShaderForge.SFN_ValueProperty,id:3435,x:31201,y:34069,ptovrint:False,ptlb:Vein3 Roll X,ptin:_Vein3RollX,varname:node_3435,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.01;n:type:ShaderForge.SFN_ValueProperty,id:7681,x:31201,y:34151,ptovrint:False,ptlb:Vein3 Roll Y,ptin:_Vein3RollY,varname:node_7681,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.01;n:type:ShaderForge.SFN_Append,id:5474,x:31394,y:34097,varname:node_5474,prsc:2|A-3435-OUT,B-7681-OUT;n:type:ShaderForge.SFN_Multiply,id:4898,x:31644,y:34085,varname:node_4898,prsc:2|A-4143-T,B-5474-OUT;n:type:ShaderForge.SFN_Add,id:4465,x:31851,y:34065,varname:node_4465,prsc:2|A-8609-UVOUT,B-4898-OUT;n:type:ShaderForge.SFN_Multiply,id:2825,x:32550,y:34150,varname:node_2825,prsc:2|A-5919-G,B-106-OUT,C-1327-RGB,D-8898-OUT;n:type:ShaderForge.SFN_ValueProperty,id:106,x:32091,y:34306,ptovrint:False,ptlb:Vein3 Intensity,ptin:_Vein3Intensity,varname:node_106,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Fresnel,id:6017,x:32091,y:34544,varname:node_6017,prsc:2|EXP-8784-OUT;n:type:ShaderForge.SFN_Slider,id:8784,x:31687,y:34567,ptovrint:False,ptlb:Vein3 Rank,ptin:_Vein3Rank,varname:node_8784,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_OneMinus,id:8898,x:32291,y:34544,varname:node_8898,prsc:2|IN-6017-OUT;n:type:ShaderForge.SFN_Color,id:1327,x:32091,y:34388,ptovrint:False,ptlb:Vein3 Color,ptin:_Vein3Color,varname:node_1327,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:5602,x:31912,y:34206,varname:node_5602,prsc:2|A-4465-OUT,B-4668-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6192,x:31549,y:34281,ptovrint:False,ptlb:Vein3 TilingX,ptin:_Vein3TilingX,varname:node_6192,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:5;n:type:ShaderForge.SFN_ValueProperty,id:868,x:31549,y:34354,ptovrint:False,ptlb:Vein3 TilingY,ptin:_Vein3TilingY,varname:node_868,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:5;n:type:ShaderForge.SFN_Append,id:4668,x:31752,y:34299,varname:node_4668,prsc:2|A-6192-OUT,B-868-OUT;n:type:ShaderForge.SFN_Sin,id:1177,x:32478,y:33382,varname:node_1177,prsc:2|IN-9255-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:8927,x:32747,y:33210,ptovrint:False,ptlb:Blink,ptin:_Blink,varname:node_8927,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-5141-OUT,B-6672-OUT;n:type:ShaderForge.SFN_Multiply,id:3686,x:32637,y:33382,varname:node_3686,prsc:2|A-1177-OUT,B-7271-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7271,x:32378,y:33614,ptovrint:False,ptlb:Amp,ptin:_Amp,varname:node_7271,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:9255,x:32329,y:33382,varname:node_9255,prsc:2|A-4143-T,B-8589-OUT;n:type:ShaderForge.SFN_ValueProperty,id:8589,x:32150,y:33499,ptovrint:False,ptlb:Fre,ptin:_Fre,varname:node_8589,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_RemapRange,id:6672,x:32862,y:33396,varname:node_6672,prsc:2,frmn:-1,frmx:1,tomn:1,tomx:2|IN-3686-OUT;proporder:3588-6313-1926-5141-5520-106-2993-3193-7710-1066-3435-7681-7241-6441-1327-8099-8784-6192-868-8927-7271-8589;pass:END;sub:END;*/

Shader "ShaderLab/Lapis/Effect/WeaponGemAdd" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _Opacticy ("Opacticy", Float ) = 1
        _Vein ("Vein", 2D) = "white" {}
        _Vein1Intensity ("Vein1 Intensity", Float ) = 1.49
        _Vein2Intensity ("Vein2 Intensity", Float ) = 0.91
        _Vein3Intensity ("Vein3 Intensity", Float ) = 1
        _Vein1RollY ("Vein1 Roll Y", Float ) = 0.12
        _Vein1RollX ("Vein1 Roll X", Float ) = 0.17
        _Vein2RollX ("Vein2 Roll X", Float ) = 0.1
        _Vein2RollY ("Vein2 Roll Y", Float ) = 0.1
        _Vein3RollX ("Vein3 Roll X", Float ) = 0.01
        _Vein3RollY ("Vein3 Roll Y", Float ) = 0.01
        _Vein1Color ("Vein1 Color", Color) = (0.4,0.3803922,1,1)
        _Vein2Color ("Vein2 Color", Color) = (0.07843138,0.3921569,0.7843137,1)
        _Vein3Color ("Vein3 Color", Color) = (0.5,0.5,0.5,1)
        _Vein2Rank ("Vein2 Rank", Range(0, 3)) = 0
        _Vein3Rank ("Vein3 Rank", Range(0, 1)) = 0
        _Vein3TilingX ("Vein3 TilingX", Float ) = 5
        _Vein3TilingY ("Vein3 TilingY", Float ) = 5
        [MaterialToggle] _Blink ("Blink", Float ) = 1.49
        _Amp ("Amp", Float ) = 0
        _Fre ("Fre", Float ) = 0
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
            Blend One One
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
            uniform float _Vein1RollY;
            uniform float _Vein1RollX;
            uniform float _Vein1Intensity;
            uniform float _Opacticy;
            uniform float _Vein2RollX;
            uniform float _Vein2RollY;
            uniform sampler2D _Vein; uniform float4 _Vein_ST;
            uniform float _Vein2Rank;
            uniform float4 _Vein2Color;
            uniform float _Vein2Intensity;
            uniform float _Vein3RollX;
            uniform float _Vein3RollY;
            uniform float _Vein3Intensity;
            uniform float _Vein3Rank;
            uniform float4 _Vein3Color;
            uniform float _Vein3TilingX;
            uniform float _Vein3TilingY;
            uniform fixed _Blink;
            uniform float _Amp;
            uniform float _Fre;
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
                float2 node_1221 = ((float2(_Vein1RollX,_Vein1RollY)*node_4143.g)+i.uv1);
                float4 node_2706 = tex2D(_Vein,TRANSFORM_TEX(node_1221, _Vein));
                float2 node_1903 = (i.uv1+(node_4143.g*float2(_Vein2RollX,_Vein2RollY)));
                float4 node_7978 = tex2D(_Vein,TRANSFORM_TEX(node_1903, _Vein));
                float2 node_5602 = ((i.uv1+(node_4143.g*float2(_Vein3RollX,_Vein3RollY)))*float2(_Vein3TilingX,_Vein3TilingY));
                float4 node_5919 = tex2D(_Vein,TRANSFORM_TEX(node_5602, _Vein));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 finalColor = ((node_2706.r*_Vein1Color.rgb*lerp( _Vein1Intensity, ((sin((node_4143.g*_Fre))*_Amp)*0.5+1.5), _Blink ))+(node_7978.b*pow(1.0-max(0,dot(normalDirection, viewDirection)),_Vein2Rank)*_Vein2Color.rgb*_Vein2Intensity)+(node_5919.g*_Vein3Intensity*_Vein3Color.rgb*(1.0 - pow(1.0-max(0,dot(normalDirection, viewDirection)),_Vein3Rank)))+(_Opacticy*_MainTex_var.rgb));
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
