
using EditorPlus;
using SeanLib.CodeTemplate;
using SeanLib.Core;
using SeanLib.ShaderLab;
using System;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEngine.UIElements;

/// <summary>
/// 注册到ui命名空间中
/// </summary>
namespace UnityEngine.UIElements
{
    public class KeyWordBinding : IBinding
    {
        private string key;
        private TemplateAsset element;
        private KeyWordInput input;
        public string Value
        {
            get
            {
                return element.GetValue(key);
            }
            set
            {
                element.SetValue(key, value);
            }
        }

        public void Init(string key, TemplateAsset Element, KeyWordInput input)
        {
            this.key = key;
            this.element = Element;
            this.input = input;
        }
        public void PreUpdate()
        {
        }

        public void Release()
        {
        }

        public void Update()
        {
            input.TextInput.value = Value;
            input.RefInputValue.text = Value;
        }
    }

    public class KeyWordInput : VisualElement, INotifyValueChanged<string>,IBindable
    {
        public new class UxmlFactory : UxmlFactory<KeyWordInput, UxmlTraits> { }
        public new class UxmlTraits : VisualElement.UxmlTraits
        {
            public UxmlBoolAttributeDescription isTextInput = new UxmlBoolAttributeDescription() { name = "isTextInput", defaultValue = true };
            public override IEnumerable<UxmlChildElementDescription> uxmlChildElementsDescription
            {
                get { yield return new UxmlChildElementDescription(typeof(VisualElement)); }
            }

            public override void Init(VisualElement ve, IUxmlAttributes bag, CreationContext cc)
            {
                base.Init(ve, bag, cc);
                ((KeyWordInput)ve).isTextInput = isTextInput.GetValueFromBag(bag, cc);
            }
        }
        protected ElementsFileAsset FileAsset = new ElementsFileAsset()
        {
            BaseType = typeof(KeyWordInput),
            UXML = "../KeyWordInput.uxml",
            USS = "../KeyWordInput.uss"
        };
        public TextField TextInput;
        public VisualElement RefInput;
        public Button RefInputValue;
        public bool isTextInput = true;

        /// <summary>
        /// 可空
        /// </summary>
        TemplateAsset thisElement;
        ShaderLibrary lab;
        public KeyWord thisKeyWord;
        ShaderElement refElement;
        KeyWord refKeyWord;
        public string value
        {
            get
            {
                return bind.Value;
            }
            set
            {
                bind.Value = value;
            }
        }
        private KeyWordBinding bind = new KeyWordBinding();
        public IBinding binding { get { return bind; } set { } }
        public string bindingPath { get => throw new NotImplementedException(); set => throw new NotImplementedException(); }

        public void SetValueWithoutNotify(string newValue)
        {
            bind.Value=newValue;
        }

        public KeyWordInput()
        {
            var treeAsset = AssetDBHelper.LoadAsset<VisualTreeAsset>(FileAsset.BaseType, FileAsset.UXML);
            treeAsset.CloneTree(this);
            this.styleSheets.Add(AssetDBHelper.LoadAsset<StyleSheet>(FileAsset.BaseType, FileAsset.USS));
        }
        public KeyWordInput(ShaderLibrary lab, KeyWord kw, TemplateAsset element) : this()
        {
            this.name = kw.key;
            this.lab = lab;
            this.thisKeyWord = kw;
            this.thisElement = element;
            bind.Init(kw.key, element,this);
            if (this.childCount == 0)
            {
                RegisterCallback<GeometryChangedEvent>(WaitUntileDisplaySetup);

            }
            else
            {
                OnDisplaySetup();
            }
        }
        public void RefreshView()
        {
            isTextInput = refKeyWord == null;
            TextInput.style.display = isTextInput ? DisplayStyle.Flex : DisplayStyle.None;
            RefInput.style.display = !isTextInput ? DisplayStyle.Flex : DisplayStyle.None;

            if(!isTextInput)
            {
               SetValueWithoutNotify(refKeyWord.key);
            }
        }

        private void WaitUntileDisplaySetup(GeometryChangedEvent evt)
        {
            OnDisplaySetup();
            UnregisterCallback<GeometryChangedEvent>(WaitUntileDisplaySetup);
        }
        void OnDisplaySetup()
        {
            TextInput = this.Q<TextField>("TextInput");
            TextInput.label = this.thisKeyWord.comment;
            //ref input
            RefInput = this.Q("RefInput");
            var refinput_label = RefInput.Q<Label>("Key_Label");
            refinput_label.text = this.thisKeyWord.comment;
            RefInputValue = RefInput.Q<Button>("Key_Ref");
            RefInputValue.clickable.clicked += () =>
            {
                refElement.HighLightAnim();
            };
            var refinput_btn = this.Q<Button>("Btn_RefInput");
            if(thisKeyWord._(KeyWord.Flag.Public))
            {
                refinput_btn.style.display = DisplayStyle.None;
            }
            refinput_btn.clickable.clicked += () =>
            {
                List<ShaderElement> selections = new List<ShaderElement>(lab.elements);
                selections.Insert(0, null);
                if (thisElement is ShaderElement)
                {
                    selections.Remove(this.thisElement as ShaderElement);
                }

                KeyWordSelector.Show(selections, refinput_btn.name, new KeyWordSelector.CallBack()
                {
                    //index =>shaderElements Index
                    OnSelected = (item, index) =>
                    {
                        this.refKeyWord = item;
                        if (index>=0)
                        {
                            refElement = selections[index];
                        }
                        RefreshView();
                    },
                    DrawSelection = (item, index) =>
                    {
                        if (KeyWordSelector.instance.searchField.GeneralValid(item.key))
                        {
                            if (GUILayout.Button(item.key, KeyWordSelector.Styles.Selection))
                            {
                                KeyWordSelector.instance.Select(item, index);
                                KeyWordSelector.instance.editorWindow.Close();
                                return;
                            }
                        }
                    }
                });

            };
        }

    }
}