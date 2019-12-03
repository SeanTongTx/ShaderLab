using EditorPlus;
using SeanLib.Core;
using ServiceTools.Reflect;
using System.Collections.Generic;
using UnityEditor;
using UnityEditor.UIElements;
using UnityEngine;
using UnityEngine.UIElements;

namespace SeanLib.CodeTemplate
{
    [CustomSeanLibEditor("ShaderLab/ShaderLaboratory")]
    public class ShaderLaboratory : CodeGenerator
    {
        protected override string UXML => "../ShaderLaboratory";
        protected override bool DefaultLayout => false;
        [MenuItem("Assets/Create/CodeTemplate/ShaderLab", priority = 50)]
        public static void ShowThis()
        {
            var seanwindow = EditorWindow.GetWindow<SeanLibManager>();
            var Item = seanwindow.SeachIndex("ShaderLab/ShaderLaboratory");
            seanwindow.SelectIndex(Item.id);
        }
        List<ShaderElement> shaderTemplates = new List<ShaderElement>();
        ScrollView ShaderElementsContainer;
        #region Preivew
        public TextField Preview_text_Properties;
        public TextField Preview_text_Shader_Tags;
        public TextField Preview_text_Pass_Tags;
        public TextField Preview_text_Vert_Input;
        public TextField Preview_text_Frag_Input;
        public TextField Preview_text_Pass_properties;
        public TextField Preview_text_Vert_process;
        public TextField Preview_text_Frag_process;
        public void Visiblity(TextField text)
        {
            text.style.visibility = string.IsNullOrEmpty(text.value) ? Visibility.Hidden : Visibility.Visible;
        }

        #endregion
        public override void OnEnable(SeanLibManager drawer)
        {
            shaderTemplates.Clear();
            var typeName = typeof(ShaderElement).ToString();
            shaderTemplates.AddRange(AssetDBHelper.LoadAssets<ShaderElement>("t:" + typeName));

            base.OnEnable(drawer);
        }
        public override void SetupUIElements()
        {
            base.SetupUIElements();
            //SetupElements
            //ToolBox
            var addBtn = this.EditorContent_Elements.Q<ToolbarButton>("ToolBar_Add");
            addBtn.clickable.clicked += () =>
            {
                SelectWindow<ShaderElement>.Show(shaderTemplates, "ShaderTemplates", new SelectWindow<ShaderElement>.CallBack()
                {
                    OnSelected = (e, i) =>
                    {
                        e.SetupElements(ShaderElementsContainer, this);
                    },
                    WindowSize = () => new Vector2(400, shaderTemplates.Count * 25 + 40),
                    DrawSelection = (e, i) =>
                    {
                        if (ShaderElementsContainer.Q(e.TemplateName) != null)
                            OnGUIUtility.Vision.GUIEnabled(false);
                        SelectWindow<ShaderElement>.DrawSelection(e, i);
                        OnGUIUtility.Vision.GUIEnabled(true);
                    }
                });
            };
            //Container
            ShaderElementsContainer = this.EditorContent_Elements.Q<ScrollView>("ElementContainer");
            ShaderElementsContainer.Clear();
            //Preivew
            Preview_text_Properties = EditorContent_Elements.Q<TextField>("Preview-text_Properties");
            Preview_text_Shader_Tags = EditorContent_Elements.Q<TextField>("Preview-text_Shader-Tags");
            Preview_text_Pass_Tags = EditorContent_Elements.Q<TextField>("Preview-text_Pass-Tags");
            Preview_text_Vert_Input = EditorContent_Elements.Q<TextField>("Preview-text_Vert-Input");
            Preview_text_Frag_Input = EditorContent_Elements.Q<TextField>("Preview-text_Frag-Input");
            Preview_text_Pass_properties = EditorContent_Elements.Q<TextField>("Preview-text_Pass-properties");
            Preview_text_Vert_process = EditorContent_Elements.Q<TextField>("Preview-text_Vert-process");
            Preview_text_Frag_process = EditorContent_Elements.Q<TextField>("Preview-text_Frag-process");

            //Generate
            var genrateButton = this.EditorContent_Elements.Q<Button>("btn-generate");
            genrateButton.clickable.clicked += OnGenerate;
        }

        public void Delete(ShaderElement se)
        {
            var delete = ShaderElementsContainer.Q(se.TemplateName);
            ShaderElementsContainer.Remove(delete);
        }
        public void RefreshKV()
        {
            foreach (var item in shaderTemplates)
            {
                item.RefreshKeyData();
            }
        }
        public override void SetInput(string key, string value)
        {
            base.SetInput(key, value);
            this.RefreshKV();
        }
    }
}