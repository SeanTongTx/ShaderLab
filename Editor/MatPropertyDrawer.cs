using EditorPlus;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
[CustomPropertyDrawer(typeof(MaterialClip))]
public class MatPropertyDrawer : DefaultPropertyDrawer
{
    protected override void OnDraw(Rect position, SerializedProperty property, GUIContent label)
    {
        if (!property.isExpanded)
        {
            OnGUIUtility.GUIProperty.DefaultPropertyField(position, property, label, false);
        }
        else
        {
            position.height = EditorGUIUtility.singleLineHeight;
            OnGUIUtility.GUIProperty.DefaultPropertyField(position, property, label, false);

            SerializedProperty from= property.FindPropertyRelative("from");
            SerializedProperty to = property.FindPropertyRelative("to");

            var propertyName = from.FindPropertyRelative("propertyName");
            var type = from.FindPropertyRelative("type");


            var f_value = from.FindPropertyRelative("value");
            var f_color = from.FindPropertyRelative("color");
            var f_vector = from.FindPropertyRelative("vector");
            var f_key = from.FindPropertyRelative("key");


            var t_value = to.FindPropertyRelative("value");
            var t_color = to.FindPropertyRelative("color");
            var t_vector = to.FindPropertyRelative("vector");
            var t_key = to.FindPropertyRelative("key");

            EditorGUI.BeginChangeCheck();
            position.y += position.height + 2f;
            EditorGUI.PropertyField(position, propertyName);
            position.y += position.height + 2f;
            EditorGUI.PropertyField(position, type);
            if(EditorGUI.EndChangeCheck())
            {
                var to_propertyName = to.FindPropertyRelative("propertyName");
                to_propertyName.stringValue = propertyName.stringValue;
                var to_type = to.FindPropertyRelative("type");
                to_type.enumValueIndex = type.enumValueIndex;
            }
            switch (type.enumValueIndex)
            {
                case 0:
                    position.y += position.height + 2f;
                    f_value.floatValue = EditorGUI.DelayedFloatField(position,"from", f_value.floatValue);
                    position.y += position.height + 2f;
                    t_value.floatValue = EditorGUI.DelayedFloatField(position, "to", t_value.floatValue); break;
                case 1:
                    position.y += position.height + 2f;
                    f_color.colorValue = EditorGUI.ColorField(position, "from", f_color.colorValue);
                    position.y += position.height + 2f;
                    t_color.colorValue = EditorGUI.ColorField(position, "to", t_color.colorValue); break;
                case 2:
                    position.y += position.height + 2f;
                    f_vector.vector4Value = EditorGUI.Vector4Field(position, "from", f_vector.vector4Value);
                    position.y += position.height + 2f;
                    t_vector.vector4Value = EditorGUI.Vector4Field(position, "to", t_vector.vector4Value); break;
                case 3:
                    position.y += position.height + 2f;
                    f_key.stringValue = EditorGUI.DelayedTextField(position, "EnableKeyWords", f_key.stringValue);
                    /*   position.y += position.height + 2f;
                       t_key.stringValue = EditorGUI.DelayedTextField(position, "to", t_key.stringValue); */
                    break;
            }
        }
    }
    public override float GetPropertyHeight(SerializedProperty property, GUIContent label)
    {
        if (!property.isExpanded)
        {
            return EditorGUIUtility.singleLineHeight+2;
        }
        SerializedProperty from = property.FindPropertyRelative("from");
        var propertyName = from.FindPropertyRelative("propertyName");
        var type = from.FindPropertyRelative("type");
        float height = (EditorGUIUtility.singleLineHeight+2) * 3;
        if (type.enumValueIndex == 2)
        {
            var f_vector = from.FindPropertyRelative("vector");
            height += EditorGUI.GetPropertyHeight(SerializedPropertyType.Vector4,new GUIContent(f_vector.displayName))+2;
            height += EditorGUI.GetPropertyHeight(SerializedPropertyType.Vector4, new GUIContent(f_vector.displayName)) + 2;
        }
        else
        {
            height += EditorGUIUtility.singleLineHeight + 2;
            height += EditorGUIUtility.singleLineHeight + 2;
        }
        return height;
    }
}
