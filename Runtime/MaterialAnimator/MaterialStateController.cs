using SeanLib.Core;
using System;
using System.Collections.Generic;
using UnityEngine;

//[CreateAssetMenu(fileName = "MaterialStateController", menuName = "MaterialStateController")]
public class MaterialStateController : ScriptableObject
{
    [Tooltip(@"默认状态中需要填写所有其他参数的默认值。")]
    public MaterialState Default = new MaterialState() { StateName = "MaterialDefaultState" };
    public List<MaterialState> States = new List<MaterialState>() { };
    private Dictionary<string, MaterialState> dic;
    public Action<MaterialState, MaterialState> OnStateEnter;
    public MaterialState GetState(string stateName)
    {
        if (stateName.IsNullOrEmpty()) return Default;
        if (dic == null)
        {
            dic = new Dictionary<string, MaterialState>();
            foreach (var state in States)
            {
                dic[state.StateName] = state;
            }
        }
        MaterialState sta = null;
        dic.TryGetValue(stateName, out sta);
        return sta;
    }
}

[Serializable]
public class MaterialClip
{
    public MatFrame from;
    public MatFrame to;
}
public enum PropertyType
{
    value,
    color,
    vector,
    keyword
}
[Serializable]
public class MatFrame
{
    public string propertyName;
    public PropertyType type;
    public Color color=Color.white;
    public float value;
    public Vector4 vector;
    public string key;
    public float weight;
}

[Serializable]
public class MaterialState
{
    public string StateName;
    [Tooltip("多材质时要对应材质编号,其中不需要修改材质也需要填null")]
    public Material[] materials;
    public List<MaterialClip> Clips = new List<MaterialClip>();
    [InspectorPlus.MinValue(0)]
    public float Duration;
    public AnimationCurve Curve = AnimationCurve.Linear(0, 0, 1, 1);
}

