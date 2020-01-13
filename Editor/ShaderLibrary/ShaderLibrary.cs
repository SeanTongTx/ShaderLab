using EditorPlus;
using SeanLib.CodeTemplate;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEditor.Presets;
using UnityEditor.UIElements;
using UnityEngine;
using UnityEngine.UIElements;

namespace SeanLib.ShaderLab
{
    [CustomSeanLibEditor("ShaderLaboratory")]
    public class ShaderLibrary : CodeGenerator
    {
        protected override ElementsFileAsset FileAsset => new ElementsFileAsset()
        {
            BaseType = this.GetType(),
            USS = "../ShaderLibrary.uss",
            UXML = "../ShaderLibrary.uxml"
        };
        protected override bool DefaultLayout => false;
        /// <summary>
        /// 所有的shader元素模板
        /// </summary>
        List<ShaderElement> elementTemplates = new List<ShaderElement>();
        List<ShaderTemplate> shaderTemplates = new List<ShaderTemplate>();
        List<ShaderPreset> shaderPresets = new List<ShaderPreset>();
        /// <summary>
        /// 当前已经添加的元素
        /// </summary>
        public List<ShaderElement> elements = new List<ShaderElement>();
        /// <summary>
        /// 当前核心模板
        /// </summary>
        protected ShaderTemplate template;
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
        //完整shader
        public TextField Preview_text_Shader_Template;
        private void InitPreview()
        {
            Preview_text_Properties = EditorContent_Elements.Q<TextField>("Preview-text_Properties");
            Preview_text_Properties.RegisterValueChangedCallback((s) => { DisplayPreview(Preview_text_Properties); });
            Preview_text_Shader_Tags = EditorContent_Elements.Q<TextField>("Preview-text_Shader-Tags");
            Preview_text_Shader_Tags.RegisterValueChangedCallback((s) => { DisplayPreview(Preview_text_Shader_Tags); });
            Preview_text_Pass_Tags = EditorContent_Elements.Q<TextField>("Preview-text_Pass-Tags");
            Preview_text_Pass_Tags.RegisterValueChangedCallback((s) => { DisplayPreview(Preview_text_Pass_Tags); });
            Preview_text_Vert_Input = EditorContent_Elements.Q<TextField>("Preview-text_Vert-Input");
            Preview_text_Vert_Input.RegisterValueChangedCallback((s) => { DisplayPreview(Preview_text_Vert_Input); });
            Preview_text_Frag_Input = EditorContent_Elements.Q<TextField>("Preview-text_Frag-Input");
            Preview_text_Frag_Input.RegisterValueChangedCallback((s) => { DisplayPreview(Preview_text_Frag_Input); });
            Preview_text_Pass_properties = EditorContent_Elements.Q<TextField>("Preview-text_Pass-properties");
            Preview_text_Pass_properties.RegisterValueChangedCallback((s) => { DisplayPreview(Preview_text_Pass_properties); });
            Preview_text_Vert_process = EditorContent_Elements.Q<TextField>("Preview-text_Vert-process");
            Preview_text_Vert_process.RegisterValueChangedCallback((s) => { DisplayPreview(Preview_text_Vert_process); });
            Preview_text_Frag_process = EditorContent_Elements.Q<TextField>("Preview-text_Frag-process");
            Preview_text_Frag_process.RegisterValueChangedCallback((s) => { DisplayPreview(Preview_text_Frag_process); });
            Preview_text_Shader_Template = EditorContent_Elements.Q<TextField>("Preview-text_Shader-Template");
            Preview_text_Shader_Template.RegisterValueChangedCallback((s) => { DisplayPreview(Preview_text_Shader_Template); });
        }
        public void DisplayPreview(TextField text)
        {
            text.style.display = string.IsNullOrEmpty(text.value) ? DisplayStyle.None : DisplayStyle.Flex;
        }
        public void PreviewElementData(ElementData elementData, string Shader)
        {
            Preview_text_Properties.value = elementData.Shader_Properties;
            Preview_text_Shader_Tags.value = elementData.Shader_Tags;
            Preview_text_Pass_Tags.value = elementData.Pass_Tags;
            Preview_text_Vert_Input.value = elementData.appdata;
            Preview_text_Frag_Input.value = elementData.v2f;
            Preview_text_Pass_properties.value = elementData.Pass_Properties;
            Preview_text_Vert_process.value = elementData.vert;
            Preview_text_Frag_process.value = elementData.frag;
            Preview_text_Shader_Template.value = Shader;
        }
        #endregion
        public override void OnEnable(SeanLibManager drawer)
        {
            template = null;
            shaderTemplates.Clear();
            elementTemplates.Clear();
            shaderPresets.Clear();
            elements.Clear();
            elementTemplates.AddRange(AssetDBHelper.LoadAssets<ShaderElement>("t:" + typeof(ShaderElement)));
            shaderTemplates.AddRange(AssetDBHelper.LoadAssets<ShaderTemplate>("t:" + typeof(ShaderTemplate)));
            shaderPresets.AddRange(AssetDBHelper.LoadAssets<ShaderPreset>("t:" + typeof(ShaderPreset)));
            base.OnEnable(drawer);
        }
        public override void OnDisable()
        {
            base.OnDisable();
        }
        public override void SetupUIElements()
        {
            base.SetupUIElements();
            //SetupElements
            //TamplateMask
            RefreshShaderTemplateMask();
            var selectShaderTemplate = EditorContent_Elements.Q<Button>("btn-SelectTemplate");
            selectShaderTemplate.clickable.clicked += () =>
            {
                SelectWindow<ShaderTemplate>.Show(shaderTemplates, "ShaderTemplates", new SelectWindow<ShaderTemplate>.CallBack()
                {
                    OnSelected = (e, i) =>
                    {
                        AddShaderTemplate(e);
                    }
                });
            };
            var selectPreset = EditorContent_Elements.Q<Button>("btn-SelectPreset");
            selectPreset.clickable.clicked += () =>
            {
                SelectWindow<ShaderPreset>.Show(shaderPresets, "ShaderPresets", new SelectWindow<ShaderPreset>.CallBack()
                {
                    OnSelected=(e,i)=>
                    {
                        var preset = e;
                        var template = AssetDBHelper.LoadAsset<ShaderTemplate>(preset.Template.name + " t: " + preset.Template.GetTargetTypeName());
                        var Ins_template= AddShaderTemplate(template);
                        preset.Template.ApplyTo(Ins_template);
                        foreach (var item in preset.Elements)
                        {
                            var ele = AssetDBHelper.LoadAsset<ShaderElement>(item.GetTargetTypeName() + " t: " + item.GetTargetTypeName());
                            var Ins_ele=AddShadeElement(ele);
                            item.ApplyTo(Ins_ele);
                        }
                    }
                });
            };
            //ToolBox
            var addBtn = this.EditorContent_Elements.Q<ToolbarButton>("ToolBar_Add");
            addBtn.clickable.clicked += () =>
            {
                SelectWindow<ShaderElement>.Show(elementTemplates, "ElementsTemplates", new SelectWindow<ShaderElement>.CallBack()
                {
                    OnSelected = (e, i) =>
                    {
                        AddShadeElement(e);
                    },
                    WindowSize = () => new Vector2(400, elementTemplates.Count * 25 + 40),
                    DrawSelection = (e, i) =>
                    {
                        if (e.AllowMultipleCount > 0)
                        {
                            var count = elements.FindAll(e1 => e1.GetType() == e.GetType()).Count;
                            if (count >= e.AllowMultipleCount)
                            {
                                OnGUIUtility.Vision.GUIEnabled(false);
                            }
                        }
                        if (e == null)
                        {
                            if (GUILayout.Button("null", SelectWindow<ShaderElement>.Styles.Selection))
                            {
                                SelectWindow<ShaderElement>.instance.Select(default(ShaderElement), i);
                                SelectWindow<ShaderElement>.instance.editorWindow.Close();
                                return;
                            }
                        }
                        else if (SelectWindow<ShaderElement>.instance.searchField.GeneralValid(e.ToString()))
                        {
                            if (GUILayout.Button(e.ToString(), SelectWindow<ShaderElement>.Styles.Selection))
                            {
                                SelectWindow<ShaderElement>.instance.Select(e, i);
                                SelectWindow<ShaderElement>.instance.editorWindow.Close();
                                return;
                            }
                        }
                        OnGUIUtility.Vision.GUIEnabled(true);

                    }
                });
            };
            var addPresetBtn = this.EditorContent_Elements.Q<ToolbarButton>("ToolBar_Preset");
            addPresetBtn.clickable.clicked += () =>
            {
                AddPreset();
            };
            //TemplateContainer
            //Container
            ShaderElementsContainer = this.EditorContent_Elements.Q<ScrollView>("ElementContainer");
            ShaderElementsContainer.Clear();
            //TODO:添加快捷键操作
            ShaderElementsContainer.AddManipulator(new ContainerManipulator(this));
            //Preivew
            InitPreview();
            //Generate
            var genrateButton = this.EditorContent_Elements.Q<Button>("btn-generate");
            genrateButton.clickable.clicked += OnGenerate;
        }
        public override void OnGenerate()
        {
            /* TODO:生成Shader maybe never do
             * if (template.Verify(elements, UserInputKV.Values))
              {
                  PreviewElementData(new ElementData(), this.template.Generate(elements, UserInputKV.Values));
              }
              */
            PreviewElementData(this.template.GenerateDatas(elements, UserInputKV.Values), null);
        }
        public void Clear()
        {
            Object.DestroyImmediate(template);
            template = null;
            var Template_Container = this.EditorContent_Elements.Q("Shader-Template_Container");
            Template_Container.Clear();
            for (int i = elements.Count - 1; i >= 0; i--)
            {
                DeleteElement(elements[i]);
            }
            RefreshShaderTemplateMask();
        }
        public ShaderTemplate AddShaderTemplate(ShaderTemplate e)
        {
            this.template = Object.Instantiate(e);
            this.template.name = this.template.name.Replace("(Clone)", string.Empty);
            RefreshShaderTemplateMask();
            var Template_Container = this.EditorContent_Elements.Q("Shader-Template_Container");
            template.SetupElements(Template_Container, this);
            return this.template;
        }
        public ShaderElement AddShadeElement(ShaderElement e)
        {
            var count = elements.FindAll(e1 => e1.GetType() == e.GetType()).Count;
            var instance = Object.Instantiate(e);
            elements.Add(instance);
            instance.name = instance.name.Replace("(Clone)", count.ToString());
            instance.SetupElements(ShaderElementsContainer, this);
            return instance;
        }
        public void DeleteElement(ShaderElement se)
        {
            se.OnDestory();
            elements.Remove(se);
            var delete = ShaderElementsContainer.Q(se.TemplateName);
            ShaderElementsContainer.Remove(delete);
            Object.DestroyImmediate(se);
        }
        public void AddPreset()
        {
            if (template == null) return;
            var folder = EditorUtility.OpenFolderPanel("保存ShaderLab预设", Application.dataPath, "");
            if (!string.IsNullOrEmpty(folder))
            {
                var Newfolder = AssetDatabase.GUIDToAssetPath(AssetDatabase.CreateFolder(PathTools.File2Asset(folder), template.GetValue(ShaderTemplate.K_Name)));
                AssetDatabase.Refresh();
                ShaderPreset preset = new ShaderPreset();
                Preset templatePre = new Preset(this.template);
                preset.Template = templatePre;
                AssetDatabase.CreateAsset(templatePre, Path.Combine(Newfolder, template.TemplateName + ".preset"));
                foreach (var item in elements)
                {
                    Preset elementPre = new Preset(item);
                    AssetDatabase.CreateAsset(elementPre, Path.Combine(Newfolder, item.TemplateName + ".preset"));
                    preset.Elements.Add(elementPre);
                }
                AssetDatabase.CreateAsset(preset, Path.Combine(Newfolder, template.GetValue(ShaderTemplate.K_Name) + ".asset"));
                AssetDatabase.Refresh();
            }
        }
        public void RefreshShaderTemplateMask()
        {
            if (template == null)
            {
                EditorContent_Elements.Q("Template-Shader_Mask").style.display = DisplayStyle.Flex;
                EditorContent_Elements.Q("Template-Shader_Template").style.display = DisplayStyle.None;
            }
            else
            {
                EditorContent_Elements.Q("Template-Shader_Mask").style.display = DisplayStyle.None;
                var Template_Shader_Template = EditorContent_Elements.Q<TextField>("Template-Shader_Template");
                Template_Shader_Template.style.display = DisplayStyle.Flex;
                Template_Shader_Template.value = template.Template;
            }
        }
    }
}