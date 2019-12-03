using System;
using System.Collections.Generic;
using System.Text;
using UnityEditor;
using UnityEngine;
using UnityEngine.UIElements;

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

        public ElementsFileAsset files = new ElementsFileAsset() { BaseType = typeof(ShaderElement), USS = "../ShaderElement.uss", UXML = "../ShaderElement.uxml" };
        protected ShaderLaboratory lab;
        private VisualElement elementRoot;
        
        public virtual void SetupElements(VisualElement container, ShaderLaboratory Lab)
        {
            this.lab = Lab;
            VisualTreeAsset nodeAsset = AssetDatabase.LoadAssetAtPath<VisualTreeAsset>(PathTools.RelativeAssetPath(files.BaseType, files.UXML));
            StyleSheet style = AssetDatabase.LoadAssetAtPath<StyleSheet>(PathTools.RelativeAssetPath(files.BaseType, files.USS));
            elementRoot = nodeAsset.CloneTree();
            elementRoot.styleSheets.Add(style);
            elementRoot.name = TemplateName;
            container.Add(elementRoot);
            DefaultSetupElements();
        }
        public virtual void DefaultSetupElements()
        {
            var elementName = elementRoot.Q<Foldout>("ElementName");
            elementName.text = TemplateName;
            var ElementsContainer = elementRoot.Q<VisualElement>("ElementsContainer");
            var ToolBox = ElementsContainer.Q("ToolBox");
            RefreshKeyData();
            var Des= ElementsContainer.Q<TextField>("Description");
            Des.value = TemplateDes;
            Des.SetEnabled(false);
            //工具箱
            ToolBox.Q<Button>("Delete").clickable.clicked += () => lab.Delete(this);
            ToolBox.Q<Button>("Preview").clickable.clicked += () => SetPreview(this);
        }
        public virtual void RefreshKeyData()
        {
            var KEYWORDS = elementRoot.Q("KeyWords");
            KEYWORDS.Clear();
            foreach (var kw in keyWords)
            {
                var key = new TextField(kw.comment);
                key.value = lab.GetInput(kw.key);
                key.isDelayed = true;
                key.RegisterValueChangedCallback((e) => { lab.SetInput(kw.key, e.newValue); });
                KEYWORDS.Add(key);
            }
        }

        public virtual void SetPreview(ShaderElement se)
        {
            lab.Preview_text_Properties.value = CodeTemplate.Generate(se.Template.Shader_Properties, se.KeyWords, lab.UserInputKV);
            lab.Visiblity(lab.Preview_text_Properties);
            lab.Preview_text_Shader_Tags.value = CodeTemplate.Generate(se.Template.Shader_Tags, se.KeyWords, lab.UserInputKV);
            lab.Visiblity(lab.Preview_text_Shader_Tags);
            lab.Preview_text_Pass_Tags.value = CodeTemplate.Generate(se.Template.Pass_Tags, se.KeyWords, lab.UserInputKV);
            lab.Visiblity(lab.Preview_text_Pass_Tags);
            lab.Preview_text_Vert_Input.value = CodeTemplate.Generate(se.Template.appdata, se.KeyWords, lab.UserInputKV);
            lab.Visiblity(lab.Preview_text_Vert_Input);
            lab.Preview_text_Frag_Input.value = CodeTemplate.Generate(se.Template.v2f, se.KeyWords, lab.UserInputKV);
            lab.Visiblity(lab.Preview_text_Frag_Input);
            lab.Preview_text_Pass_properties.value = CodeTemplate.Generate(se.Template.Pass_Properties, se.KeyWords, lab.UserInputKV);
            lab.Visiblity(lab.Preview_text_Pass_properties);
            lab.Preview_text_Vert_process.value = CodeTemplate.Generate(se.Template.vert, se.KeyWords, lab.UserInputKV);
            lab.Visiblity(lab.Preview_text_Vert_process);
            lab.Preview_text_Frag_process.value = CodeTemplate.Generate(se.Template.frag, se.KeyWords, lab.UserInputKV);
            lab.Visiblity(lab.Preview_text_Frag_process);
        }
    }
}
