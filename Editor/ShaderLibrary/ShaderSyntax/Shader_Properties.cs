using EditorPlus;
using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine;

namespace SeanLib.ShaderLab
{
    public enum Property_Attribute
    {
        //Unity builtin 0-
        HideInInspector                         =0,
        NoScaleOffset                           =1,
        Normal                                  =2,
        HDR                                     =3,
        Gamma                                   =4,
        PerRendererData                         =5,
        //MaterialPropertyDrawer 50-
        Toggle                                  =50,
        Enum                                    =51,
        KeywordEnum                             =52,
        PowerSlider                             =53,
        IntRange                                =54,
        Space                                   =55,
        Header                                  =56
        //other 100-
    }
    [Serializable]
    public class AttributeData
    {
        public bool active;
        public Property_Attribute attribute;
        public string data;
    }
    public class Shader_Properties
    {
        public static bool IsDataAttribute(Property_Attribute attribute)
        {
            return (attribute == Property_Attribute.Toggle ||
                attribute == Property_Attribute.Enum ||
                attribute == Property_Attribute.KeywordEnum ||
                attribute == Property_Attribute.PowerSlider ||
                attribute == Property_Attribute.Space ||
                attribute == Property_Attribute.Header);
        }
        public static string PropertyAttribute(Property_Attribute attribute, string data=null)
        {
            if (IsDataAttribute(attribute))
            {
                if (string.IsNullOrEmpty(data))
                {
                    return string.Format("[{0}]", attribute.ToString());
                }
                else
                {
                    return string.Format("[{0}({1})]", attribute.ToString(), data);
                }
            }   
            else
            {
                return string.Format("[{0}]", attribute.ToString());
            }
        }
        public static string PropertyAttributes(List<AttributeData>attributeswithData)
        {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < attributeswithData.Count; i++)
            {
                var item = attributeswithData[i];
                if (item.active)
                {
                    sb.Append(PropertyAttribute(item.attribute, item.data));
                }
            }
            return sb.ToString();
        }
        public static string DefaultColor(UnityEngine.Color color)
        {
            return DefaultVector(color);
        }
        public static string DefaultVector(Vector4 vector)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("(")
                .Append(vector.x).Append(",")
                .Append(vector.y).Append(",")
                .Append(vector.z).Append(",")
                .Append(vector.w)
                .Append(")");
            return sb.ToString();
        }
        public static void GUI(AttributeData attributeData,GUIStyle style, params GUILayoutOption[] options)
        {
            if(IsDataAttribute(attributeData.attribute))
            {
                GUILayout.BeginHorizontal();
                {
                    attributeData.active=GUILayout.Toggle(attributeData.active, attributeData.attribute.ToString(), style, options);
                    OnGUIUtility.Vision.GUIEnabled(attributeData.active);
                    {
                        attributeData.data = GUILayout.TextField(attributeData.data);
                    }
                    OnGUIUtility.Vision.GUIEnabled(true);
                }
                GUILayout.EndHorizontal();
            }
            else
            {
                attributeData.active = GUILayout.Toggle(attributeData.active, attributeData.attribute.ToString(), style, options);
            }
        }
        private static void AttributeDataGUI(AttributeData data)
        {
            switch(data.attribute)
            {
                default: data.data = GUILayout.TextField(data.data);return;
            }
        }
    }
}