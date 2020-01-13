using EditorPlus;
using SeanLib.CodeTemplate;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEngine.UIElements;

namespace SeanLib.ShaderLab
{
    public class BasicShaderTemplate: ShaderTemplate
    {
        public override string Generate(List<ShaderElement> elements, List<KeyWordValue> UserInput)
        {
            GenerateDatas(elements, UserInput);
            MergeValues(UserInput);
            //强制显示被隐藏的Generate方法
            var baseType = ((TemplateAsset)this);

            return baseType.Generate(UserInput);
        }

        public override ElementData GenerateDatas(List<ShaderElement> elements, List<KeyWordValue> UserInput)
        {
            ElementData generate = new ElementData();
            //处理所有元素的引用项
            foreach (var item in elements)
            {
                item.HandleRefKeyWords(UserInput);
            }
            foreach (var item in elements)
            {
                generate.Merge(item.Generate());
            }
            HandleRefKeyWords(UserInput);
            this.SetValue("/*SHADER_PROPERTIES*/", generate.Shader_Properties);
            this.SetValue("/*SHADER_TAGS*/", generate.Shader_Tags);
            this.SetValue("/*PASS_TAGS*/", generate.Pass_Tags);
            this.SetValue("/*PASS_PRAGMAS*/", generate.Pass_Pragmas);
            this.SetValue("/*APPDATA_PRAGMAS*/", generate.appdata);
            this.SetValue("/*V2F*/", generate.v2f);
            this.SetValue("/*PASS_PROPERTIES*/", generate.Pass_Properties);
            this.SetValue("/*VERT_PROCESS*/", generate.vert);
            this.SetValue("/*FRAG_PROCESS*/", generate.frag);
            return generate;
        }
    }
}
