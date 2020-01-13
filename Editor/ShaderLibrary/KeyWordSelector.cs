
using EditorPlus;
using SeanLib.CodeTemplate;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using SeanLib.Core;

namespace SeanLib.ShaderLab
{
    public class KeyWordSelector : SelectWindow<KeyWord>
    {
        private static KeyWordSelector Content = new KeyWordSelector();
        public static void Show(List<ShaderElement>elements,string controlId, CallBack callBack)
        {
            instance = Content;
            instance.OnEnable(null, controlId, callBack);
            Content.shaderElements = elements;
            try
            {
                PopupWindow.Show(new Rect(Event.current.mousePosition.DeltaX(-100), Vector2.zero), instance);
            }
            catch
            {
                //  EditorGUIUtility.ExitGUI();
            }
        }
        public List<ShaderElement> shaderElements = new List<ShaderElement>();
        private OnGUIUtility.Components.FadePool fadeGroups = new OnGUIUtility.Components.FadePool();
        public override void OnGUI(Rect rect)
        {
           // base.OnGUI(rect);
            var searching = searchField.OnToolbarGUI();
            if(shaderElements.Count>0)
            {
                v = EditorGUILayout.BeginScrollView(v);
                for (int i = 0; i < shaderElements.Count; i++)
                {
                    var ele = shaderElements[i];
                    if(ele==null)
                    {
                        if (GUILayout.Button("NULL", KeyWordSelector.Styles.Selection))
                        {
                            KeyWordSelector.instance.Select(null, -1);
                            KeyWordSelector.instance.editorWindow.Close();
                            return;
                        }
                        continue;
                    }
                    var fade= fadeGroups.Get(ele.TemplateName, editorWindow.Repaint);
                    if (fade.OnGuiBegin(ele.TemplateName, OnGUIUtility.Styles.Title))
                    {
                        for (int y = 0; y < ele.KeyWords.Length; y++)
                        {
                            var kw = ele.KeyWords[y];
                            if (kw._(KeyWord.Flag.Public))
                            {
                                callback.DrawSelection(kw, i);
                            }
                        }
                    }
                    fade.OnGuiEnd();
                }
                EditorGUILayout.EndScrollView();
            }
        }
        public override void OnClose()
        {
            fadeGroups.OnDisable(editorWindow.Repaint);
            base.OnClose();
        }
    }
}