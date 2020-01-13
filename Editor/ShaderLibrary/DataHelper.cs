using System;
using UnityEngine;
using EditorPlus;
namespace SeanLib.ShaderLab
{
    [Serializable]
    public class ElementData
    {
        [Multiline]
        public string Shader_Properties;
        [Multiline]
        public string Shader_Tags;
        [Multiline]
        public string Pass_Tags;
        [Multiline]
        public string Pass_Pragmas;
        [Multiline]
        public string appdata;
        [Multiline]
        public string v2f;
        [Multiline]
        public string Pass_Properties;
        [Multiline]
        public string vert;
        [Multiline]
        public string frag;
        public void Merge(ElementData data)
        {
            if(!string.IsNullOrEmpty(data.Shader_Properties))
                this.Shader_Properties = this.Shader_Properties + Environment.NewLine + data.Shader_Properties;
            if (!string.IsNullOrEmpty(data.Shader_Tags))
                this.Shader_Tags = this.Shader_Tags + Environment.NewLine + data.Shader_Tags;
            if (!string.IsNullOrEmpty(data.Pass_Tags))
                this.Pass_Tags = this.Pass_Tags + Environment.NewLine + data.Pass_Tags;
            if (!string.IsNullOrEmpty(data.Pass_Pragmas))
                this.Pass_Pragmas = this.Pass_Pragmas + Environment.NewLine + data.Pass_Pragmas;
            if (!string.IsNullOrEmpty(data.appdata))
                this.appdata = this.appdata + Environment.NewLine + data.appdata;
            if (!string.IsNullOrEmpty(data.v2f))
                this.v2f = this.v2f + Environment.NewLine + data.v2f;
            if (!string.IsNullOrEmpty(data.Pass_Properties))
                this.Pass_Properties = this.Pass_Properties + Environment.NewLine + data.Pass_Properties;
            if (!string.IsNullOrEmpty(data.vert))
                this.vert = this.vert + Environment.NewLine + data.vert;
            if (!string.IsNullOrEmpty(data.frag))
                this.frag = this.frag + Environment.NewLine + data.frag;
        }
    }
    [Serializable]
    public enum Space
    {
       Object       =0,
       World        =1,
       Clip         =2,
       Screen       =3,
       Tangent      =4,
    }
    public class DataHelper
    {
    }
}