using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine;
using static SeanLib.Core.InspectorPlus;

namespace SeanLib.CodeTemplate
{
    [Serializable]
    public struct ElementData
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
    }
    [CreateAssetMenu(fileName = "NewElement", menuName = "CodeTemplate/ShaderElement", order = 50)]
    public class ShaderElement : ScriptableObject
    {
        [Multiline]
        public string TemplateDes;
        public ElementData Template;
        [SerializeField]
        private KeyWord[] keyWords;
        public string TemplateName => name;
        public KeyWord[] KeyWords => keyWords;

        public ElementData Generate(Dictionary<string, string> KeyValues)
        {
            ElementData instanceData;
            instanceData.Shader_Properties = Generate(KeyValues, Template.Shader_Properties);
            instanceData.Shader_Tags = Generate(KeyValues, Template.Shader_Tags);
            instanceData.Pass_Tags = Generate(KeyValues, Template.Pass_Tags);
            instanceData.Pass_Pragmas = Generate(KeyValues, Template.Pass_Pragmas);
            instanceData.appdata = Generate(KeyValues, Template.appdata);
            instanceData.v2f = Generate(KeyValues, Template.v2f);
            instanceData.Pass_Properties = Generate(KeyValues, Template.Pass_Properties);
            instanceData.vert = Generate(KeyValues, Template.vert);
            instanceData.frag = Generate(KeyValues, Template.frag);
            return instanceData;
        }
        public void Debug(Dictionary<string, string> KeyValues)
        {
            var data = Generate(KeyValues);
            UnityEngine.Debug.Log("Shader_Properties----" + data.Shader_Properties);
            UnityEngine.Debug.Log("Shader_Tags----" + data.Shader_Tags);
            UnityEngine.Debug.Log("Pass_Tags----" + data.Pass_Tags);
            UnityEngine.Debug.Log("appdata----" + data.appdata);
            UnityEngine.Debug.Log("v2f----" + data.v2f);
            UnityEngine.Debug.Log("Pass_Properties----" + data.Pass_Properties);
            UnityEngine.Debug.Log("vert----" + data.vert);
            UnityEngine.Debug.Log("frag----" + data.frag);
        }
        protected virtual string Generate(Dictionary<string, string> KeyValues, string template)
        {
            StringBuilder sb = new StringBuilder(template);
            for (int i = 0; i < KeyWords.Length; i++)
            {
                if (KeyValues.ContainsKey(KeyWords[i].key))
                    sb.Replace(KeyWords[i].key, KeyValues[KeyWords[i].key]);
            }
            return sb.ToString();
        }
    }
}
