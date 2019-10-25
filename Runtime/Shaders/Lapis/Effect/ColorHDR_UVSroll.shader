// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32719,y:32712,varname:node_3138,prsc:2|emission-128-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32049,y:32333,ptovrint:False,ptlb:Color1,ptin:_Color1,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.8037508,c2:0.4097098,c3:0.8773585,c4:1;n:type:ShaderForge.SFN_Tex2d,id:2826,x:32051,y:32802,ptovrint:False,ptlb:MaiTex,ptin:_MaiTex,varname:node_2826,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-1167-OUT;n:type:ShaderForge.SFN_Multiply,id:128,x:32405,y:32807,varname:node_128,prsc:2|A-4519-OUT,B-2826-RGB,C-1656-OUT,D-3397-A;n:type:ShaderForge.SFN_TexCoord,id:164,x:31525,y:32769,varname:node_164,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_ValueProperty,id:9168,x:31351,y:33042,ptovrint:False,ptlb:USpeed,ptin:_USpeed,varname:node_9168,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:8849,x:31351,y:33124,ptovrint:False,ptlb:VSpeed,ptin:_VSpeed,varname:node_8849,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Append,id:5819,x:31525,y:33054,varname:node_5819,prsc:2|A-9168-OUT,B-8849-OUT;n:type:ShaderForge.SFN_Time,id:9964,x:31525,y:32920,varname:node_9964,prsc:2;n:type:ShaderForge.SFN_Multiply,id:1716,x:31698,y:33064,varname:node_1716,prsc:2|A-9964-T,B-5819-OUT;n:type:ShaderForge.SFN_Add,id:1167,x:31855,y:32923,varname:node_1167,prsc:2|A-164-UVOUT,B-1716-OUT;n:type:ShaderForge.SFN_VertexColor,id:3397,x:32051,y:33066,varname:node_3397,prsc:2;n:type:ShaderForge.SFN_ValueProperty,id:1656,x:32051,y:32994,ptovrint:False,ptlb:TexInt,ptin:_TexInt,varname:node_1656,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Fresnel,id:9296,x:32047,y:32645,varname:node_9296,prsc:2|EXP-8629-OUT;n:type:ShaderForge.SFN_Color,id:3457,x:32047,y:32496,ptovrint:False,ptlb:Color2,ptin:_Color2,varname:node_3457,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.360404,c2:0.6796122,c3:0.8396226,c4:1;n:type:ShaderForge.SFN_Lerp,id:4519,x:32289,y:32442,varname:node_4519,prsc:2|A-7241-RGB,B-3457-RGB,T-9296-OUT;n:type:ShaderForge.SFN_Slider,id:8629,x:31666,y:32657,ptovrint:False,ptlb:ColorClamp,ptin:_ColorClamp,varname:node_8629,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.6153846,max:1;proporder:2826-1656-7241-3457-8629-9168-8849;pass:END;sub:END;*/

Shader "ShaderLab/Lapis/Effect/ColorHDR_UVSroll" {
    Properties {
        _MaiTex ("MaiTex", 2D) = "white" {}
        _TexInt ("TexInt", Float ) = 0
        [HDR]_Color1 ("Color1", Color) = (0.8037508,0.4097098,0.8773585,1)
        [HDR]_Color2 ("Color2", Color) = (0.360404,0.6796122,0.8396226,1)
        _ColorClamp ("ColorClamp", Range(0, 1)) = 0.6153846
        _USpeed ("USpeed", Float ) = 0
        _VSpeed ("VSpeed", Float ) = 0
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Blend One One
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma target 3.0
            uniform float4 _Color1;
            uniform sampler2D _MaiTex; uniform float4 _MaiTex_ST;
            uniform float _USpeed;
            uniform float _VSpeed;
            uniform float _TexInt;
            uniform float4 _Color2;
            uniform float _ColorClamp;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
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
                float4 node_9964 = _Time;
                float2 node_1167 = (i.uv0+(node_9964.g*float2(_USpeed,_VSpeed)));
                float4 _MaiTex_var = tex2D(_MaiTex,TRANSFORM_TEX(node_1167, _MaiTex));
                float3 emissive = (lerp(_Color1.rgb,_Color2.rgb,pow(1.0-max(0,dot(normalDirection, viewDirection)),_ColorClamp))*_MaiTex_var.rgb*_TexInt*i.vertexColor.a);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
