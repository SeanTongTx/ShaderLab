// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32420,y:32607,varname:node_3138,prsc:2|alpha-3568-OUT,refract-5382-OUT;n:type:ShaderForge.SFN_TexCoord,id:4507,x:30291,y:33018,varname:node_4507,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:5382,x:32147,y:32908,varname:node_5382,prsc:2|A-791-OUT,B-2376-OUT;n:type:ShaderForge.SFN_Tex2d,id:8332,x:31712,y:32908,ptovrint:False,ptlb:Shapen,ptin:_Shapen,varname:node_8332,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-242-OUT;n:type:ShaderForge.SFN_ComponentMask,id:791,x:31919,y:32908,varname:node_791,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-8332-RGB;n:type:ShaderForge.SFN_Slider,id:398,x:31684,y:33150,ptovrint:False,ptlb:Distortion,ptin:_Distortion,varname:node_398,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Add,id:242,x:31457,y:33003,varname:node_242,prsc:2|A-4507-UVOUT,B-280-OUT,C-2206-OUT;n:type:ShaderForge.SFN_Slider,id:9905,x:30883,y:33232,ptovrint:False,ptlb:OffsetX,ptin:_OffsetX,varname:node_9905,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.392599,max:1;n:type:ShaderForge.SFN_Slider,id:2451,x:30883,y:33364,ptovrint:False,ptlb:OffsetY,ptin:_OffsetY,varname:node_2451,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Append,id:280,x:31275,y:33250,varname:node_280,prsc:2|A-9905-OUT,B-2451-OUT;n:type:ShaderForge.SFN_Noise,id:2206,x:31318,y:32659,varname:node_2206,prsc:2|XY-1097-UVOUT;n:type:ShaderForge.SFN_Posterize,id:8785,x:30734,y:32352,varname:node_8785,prsc:2|IN-4021-OUT,STPS-4470-OUT;n:type:ShaderForge.SFN_Slider,id:4470,x:30599,y:32556,ptovrint:False,ptlb:Density,ptin:_Density,varname:node_4470,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:15.38462,max:100;n:type:ShaderForge.SFN_Panner,id:1097,x:31330,y:32416,varname:node_1097,prsc:2,spu:0.1,spv:0.1|UVIN-8785-OUT,DIST-3820-OUT;n:type:ShaderForge.SFN_Slider,id:1030,x:30535,y:32799,ptovrint:False,ptlb:SpeedNoise,ptin:_SpeedNoise,varname:node_1030,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5974633,max:1;n:type:ShaderForge.SFN_Time,id:4548,x:30692,y:32633,varname:node_4548,prsc:2;n:type:ShaderForge.SFN_Multiply,id:3820,x:31061,y:32600,varname:node_3820,prsc:2|A-4548-T,B-7296-OUT,C-5509-OUT;n:type:ShaderForge.SFN_Vector1,id:5509,x:31061,y:32794,varname:node_5509,prsc:2,v1:0.001;n:type:ShaderForge.SFN_RemapRange,id:4021,x:30452,y:32355,varname:node_4021,prsc:2,frmn:0,frmx:1,tomn:1,tomx:2|IN-4507-UVOUT;n:type:ShaderForge.SFN_RemapRange,id:2376,x:32080,y:33149,varname:node_2376,prsc:2,frmn:0,frmx:1,tomn:0,tomx:0.02|IN-398-OUT;n:type:ShaderForge.SFN_RemapRange,id:7296,x:30862,y:32850,varname:node_7296,prsc:2,frmn:0,frmx:1,tomn:0,tomx:0.1|IN-1030-OUT;n:type:ShaderForge.SFN_Vector1,id:3568,x:32147,y:32845,varname:node_3568,prsc:2,v1:0;proporder:8332-398-9905-2451-4470-1030;pass:END;sub:END;*/

Shader "Lapis/Effect/ChannelShift" {
    Properties {
        _Shapen ("Shapen", 2D) = "white" {}
        _Distortion ("Distortion", Range(0, 1)) = 0
        _OffsetX ("OffsetX", Range(0, 1)) = 0.392599
        _OffsetY ("OffsetY", Range(0, 1)) = 0
        _Density ("Density", Range(0, 100)) = 15.38462
        _SpeedNoise ("SpeedNoise", Range(0, 1)) = 0.5974633
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
			"Queue" = "Transparent"
        }
        GrabPass{"_BackgroundTexture" }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
			cull off
            // Blend SrcAlpha OneMinusSrcAlpha
            // ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma target 3.0
            uniform sampler2D _BackgroundTexture;
            uniform sampler2D _Shapen; uniform float4 _Shapen_ST;
            uniform float _Distortion;
            uniform float _OffsetX;
            uniform float _OffsetY;
            uniform float _Density;
            uniform float _SpeedNoise;
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
            float4 frag(VertexOutput i) : COLOR {
                float4 node_4548 = _Time;
                float2 node_1097 = (floor((i.uv0*1.0+1.0) * _Density) / (_Density - 1)+(node_4548.g*(_SpeedNoise*0.1+0.0)*0.001)*float2(0.1,0.1));
                float2 node_2206_skew = node_1097 + 0.2127+node_1097.x*0.3713*node_1097.y;
                float2 node_2206_rnd = 4.789*sin(489.123*(node_2206_skew));
                float node_2206 = frac(node_2206_rnd.x*node_2206_rnd.y*(1+node_2206_skew.x));
                float2 node_242 = (i.uv0+(node_4548.g*float2(_OffsetX,_OffsetY))+node_2206);
                float4 _Shapen_var = tex2D(_Shapen,TRANSFORM_TEX(node_242, _Shapen));
                float2 sceneUVs = (i.projPos.xy / i.projPos.w) + (_Shapen_var.rgb.rg*(_Distortion*0.02+0.0));
                float4 sceneColor = tex2D(_BackgroundTexture, sceneUVs);
////// Lighting:
                float3 finalColor = 0;
                return fixed4(lerp(sceneColor.rgb, finalColor,0.0),sceneColor.a);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
