using SeanLib.Core;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[RequireComponent(typeof(Renderer))]
public class MaterialAnimator : MonoBehaviour
{
    [InspectorPlus.Expandable]
    public MaterialStateController controller;
    [NonSerialized]
    private MaterialState _currentState;
    public MaterialState Current
    {
        get
        {
            if (_currentState == null)
            {
                _currentState = controller.Default;
            }
            return _currentState;
        }
        set
        {
            _currentState = value;
        }
    }

    [InspectorPlus.ReadOnly]
    public bool Playing;
    public float time { get; private set; }
    Renderer renderer;
    public Renderer Renderer
    {
        get
        {
            renderer = renderer ?? GetComponent<Renderer>();
            return renderer;
        }
    }
    /// <summary>
    /// 修改材质
    /// </summary>
    /// <param name="state"></param>
    public void ChangeMatTo(MaterialState state)
    {
        if (state.materials != null)
        {
            List<string> keywords = new List<string>();
            foreach (var clip in state.Clips)
            {
                if(clip.from.type==PropertyType.keyword)
                {
                    keywords.Add(clip.from.key);
                }
            }
            Material[] mats = new Material[state.materials.Length];
            for (int i = 0; i < state.materials.Length; i++)
            {
                var mat = state.materials[i];
                if(mat==null)
                {
                    mats[i] = Renderer.materials[i];
                }
                else
                {
                    mats[i] = mat;
                }
                mats[i].shaderKeywords = keywords.ToArray();
            }
            Renderer.materials = mats;
        }
    }
    /// <summary>
    /// 获取Render属性
    /// </summary>
    /// <param name="properties"></param>
    public void ApplyProperties(float weight)
    {
        var block = Renderer.GetPropertyBlock();
        foreach (var clip in Current.Clips)
        {
            switch (clip.from.type)
            {
                case PropertyType.value:
                    var fvalue = clip.from.value;
                    var tvalue = fvalue + (clip.to.value - fvalue) * weight;
                    block.SetFloat(clip.from.propertyName, tvalue);
                    break;
                case PropertyType.color:
                    var fcolor = clip.from.color;
                    var tcolor = Color.LerpUnclamped(fcolor, clip.to.color, weight);
                    block.SetColor(clip.from.propertyName, tcolor);
                    break;
                case PropertyType.vector:
                    var fvect = clip.from.vector;
                    var tvect = Vector4.LerpUnclamped(fvect, clip.to.vector, weight);
                    block.SetVector(clip.from.propertyName, tvect);
                    break;
            }
        }
        Renderer.SetPropertyBlock(block);
    }
    void Update()
    {
        if (!Playing) return;
        float weight = 1;
        if (Current.Duration > 0)
        {
            time = time + Time.deltaTime;
            time = time > Current.Duration ? Current.Duration : time;
            weight = Current.Curve.Evaluate(time / Current.Duration);
        }
        ApplyProperties(weight);
        if(time>=Current.Duration)
        {
            Playing = false;
        }
    }
    public void Play(string stateName=null)
    {
        if (!controller) return;
        var state = controller.GetState(stateName);
        if (state == null||Current== state) return;
        Playing = true;
        if(controller.OnStateEnter!=null)
        {
            controller.OnStateEnter.Invoke(Current, state);
        }
        Current = state;
        time = 0;
        ChangeMatTo(Current);
    }
    #region Editor Debug
    [InspectorPlus.Button]
    public void TestPlay()
    {
        int index=this.controller.States.IndexOf(Current);
        index = (index + 1) % controller.States.Count;
        Play(controller.States[index].StateName);
    }
    [InspectorPlus.Button]
    public void Default()
    {
        Play("");
    }
    #endregion
}
