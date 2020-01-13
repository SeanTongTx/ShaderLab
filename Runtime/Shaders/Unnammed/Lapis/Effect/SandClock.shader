// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33227,y:32337,varname:node_3138,prsc:2|emission-5225-OUT,clip-2404-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32409,y:31741,ptovrint:False,ptlb:Color_Inside,ptin:_Color_Inside,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.6431373,c2:0.2297375,c3:0.07058825,c4:1;n:type:ShaderForge.SFN_Fresnel,id:534,x:32424,y:32286,varname:node_534,prsc:2|EXP-1290-OUT;n:type:ShaderForge.SFN_Slider,id:1290,x:32088,y:32305,ptovrint:False,ptlb:Color_Deflection,ptin:_Color_Deflection,varname:node_1290,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1.877494,max:3;n:type:ShaderForge.SFN_Lerp,id:9819,x:32678,y:32168,varname:node_9819,prsc:2|A-7241-RGB,B-4435-RGB,T-7972-OUT;n:type:ShaderForge.SFN_Color,id:4435,x:32409,y:31915,ptovrint:False,ptlb:Color_Outer,ptin:_Color_Outer,varname:node_4435,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.9433962,c2:0.6884012,c3:0.3871485,c4:1;n:type:ShaderForge.SFN_Add,id:5225,x:32915,y:32168,varname:node_5225,prsc:2|A-9819-OUT,B-7922-OUT;n:type:ShaderForge.SFN_Tex2d,id:7756,x:32424,y:32435,ptovrint:False,ptlb:VeinTex,ptin:_VeinTex,varname:node_7756,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-1388-OUT;n:type:ShaderForge.SFN_Multiply,id:7922,x:32827,y:32438,varname:node_7922,prsc:2|A-7756-RGB,B-6569-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6569,x:32590,y:32505,ptovrint:False,ptlb:VeinInt,ptin:_VeinInt,varname:node_6569,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_FragmentPosition,id:2315,x:31814,y:32883,varname:node_2315,prsc:2;n:type:ShaderForge.SFN_ObjectPosition,id:4217,x:31814,y:33021,varname:node_4217,prsc:2;n:type:ShaderForge.SFN_Subtract,id:7550,x:32023,y:32983,varname:node_7550,prsc:2|A-2315-Y,B-4217-Y;n:type:ShaderForge.SFN_Add,id:1752,x:32415,y:32984,varname:node_1752,prsc:2|A-7550-OUT,B-956-OUT;n:type:ShaderForge.SFN_Vector3,id:8664,x:31824,y:33164,varname:node_8664,prsc:2,v1:0,v2:1.5,v3:0;n:type:ShaderForge.SFN_ComponentMask,id:956,x:32037,y:33164,varname:node_956,prsc:2,cc1:1,cc2:-1,cc3:-1,cc4:-1|IN-8664-OUT;n:type:ShaderForge.SFN_Multiply,id:820,x:32268,y:33164,varname:node_820,prsc:2|A-956-OUT,B-6907-OUT;n:type:ShaderForge.SFN_Slider,id:6907,x:31928,y:33362,ptovrint:False,ptlb:Water_Level,ptin:_Water_Level,varname:node_6907,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-3,cur:0.6923077,max:3;n:type:ShaderForge.SFN_Subtract,id:677,x:32648,y:32984,varname:node_677,prsc:2|A-1752-OUT,B-820-OUT;n:type:ShaderForge.SFN_Clamp01,id:1347,x:32648,y:32821,varname:node_1347,prsc:2|IN-677-OUT;n:type:ShaderForge.SFN_OneMinus,id:9164,x:32985,y:32984,varname:node_9164,prsc:2|IN-1347-OUT;n:type:ShaderForge.SFN_TexCoord,id:2392,x:31740,y:32240,varname:node_2392,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:1388,x:31945,y:32416,varname:node_1388,prsc:2|A-2392-UVOUT,B-1269-OUT;n:type:ShaderForge.SFN_ValueProperty,id:9996,x:31286,y:32403,ptovrint:False,ptlb:USpeed,ptin:_USpeed,varname:node_9996,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:4931,x:31286,y:32489,ptovrint:False,ptlb:VSpeed,ptin:_VSpeed,varname:node_4931,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Append,id:8099,x:31488,y:32434,varname:node_8099,prsc:2|A-9996-OUT,B-4931-OUT;n:type:ShaderForge.SFN_Time,id:2786,x:31464,y:32267,varname:node_2786,prsc:2;n:type:ShaderForge.SFN_Multiply,id:1269,x:31681,y:32399,varname:node_1269,prsc:2|A-2786-TSL,B-8099-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:2404,x:33021,y:32650,ptovrint:False,ptlb:Pisiton_Switch,ptin:_Pisiton_Switch,varname:node_2404,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-9164-OUT,B-1347-OUT;n:type:ShaderForge.SFN_Multiply,id:8890,x:32409,y:32128,varname:node_8890,prsc:2|A-1290-OUT,B-2392-V;n:type:ShaderForge.SFN_SwitchProperty,id:7972,x:32590,y:32307,ptovrint:False,ptlb:Deflection Transform,ptin:_DeflectionTransform,varname:node_7972,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-534-OUT,B-8890-OUT;proporder:7756-6569-7241-4435-1290-7972-9996-4931-6907-2404;pass:END;sub:END;*/

Shader "Lapis/Effect/SandClock" {
    Properties {
        _VeinTex ("VeinTex", 2D) = "white" {}
        _VeinInt ("VeinInt", Float ) = 1
        [HDR]_Color_Inside ("Color_Inside", Color) = (0.6431373,0.2297375,0.07058825,1)
        [HDR]_Color_Outer ("Color_Outer", Color) = (0.9433962,0.6884012,0.3871485,1)
        _Color_Deflection ("Color_Deflection", Range(0, 3)) = 1.877494
        [MaterialToggle] _DeflectionTransform ("Deflection Transform", Float ) = 0
        _USpeed ("USpeed", Float ) = 0
        _VSpeed ("VSpeed", Float ) = 0
        _Water_Level ("Water_Level", Range(-3, 3)) = 0.6923077
        [MaterialToggle] _Pisiton_Switch ("Pisiton_Switch", Float ) = 0.5384616
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
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
            uniform float4 _Color_Inside;
            uniform float _Color_Deflection;
            uniform float4 _Color_Outer;
            uniform sampler2D _VeinTex; uniform float4 _VeinTex_ST;
            uniform float _VeinInt;
            uniform float _Water_Level;
            uniform float _USpeed;
            uniform float _VSpeed;
            uniform fixed _Pisiton_Switch;
            uniform fixed _DeflectionTransform;
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
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float node_956 = float3(0,1.5,0).g;
                float node_1347 = saturate((((i.posWorld.g-objPos.g)+node_956)-(node_956*_Water_Level)));
                clip(lerp( (1.0 - node_1347), node_1347, _Pisiton_Switch ) - 0.5);
////// Lighting:
////// Emissive:
                float4 node_2786 = _Time;
                float2 node_1388 = (i.uv0+(node_2786.r*float2(_USpeed,_VSpeed)));
                float4 _VeinTex_var = tex2D(_VeinTex,TRANSFORM_TEX(node_1388, _VeinTex));
                float3 emissive = (lerp(_Color_Inside.rgb,_Color_Outer.rgb,lerp( pow(1.0-max(0,dot(normalDirection, viewDirection)),_Color_Deflection), (_Color_Deflection*i.uv0.g), _DeflectionTransform ))+(_VeinTex_var.rgb*_VeinInt));
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
            uniform float _Water_Level;
            uniform fixed _Pisiton_Switch;
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float4 posWorld : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                float node_956 = float3(0,1.5,0).g;
                float node_1347 = saturate((((i.posWorld.g-objPos.g)+node_956)-(node_956*_Water_Level)));
                clip(lerp( (1.0 - node_1347), node_1347, _Pisiton_Switch ) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
	Fallback "Hidden/Lapis/VertexLit"
    CustomEditor "ShaderForgeMaterialInspector"
}
