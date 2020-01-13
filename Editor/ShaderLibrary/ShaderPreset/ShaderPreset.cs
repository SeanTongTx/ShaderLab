using SeanLib.ShaderLab;
using System.Collections.Generic;
using UnityEditor.Presets;
using UnityEngine;
//[CreateAssetMenu(fileName = "ShaderPreset", menuName = "ShaderPreset")]
public class ShaderPreset: ScriptableObject
{
    public Preset Template;
    public List<Preset> Elements=new List<Preset>();
}