using EditorPlus;
using SeanLib.ShaderLab;
using System;
using UnityEditor;
using UnityEngine;
using UnityEngine.UIElements;
public class ContainerManipulator : MouseManipulator
{
    ShaderLibrary lab;
    public ContainerManipulator(ShaderLibrary lab)
    {
        this.lab = lab;
        this.activators.Add(new ManipulatorActivationFilter { clickCount = 1, button = MouseButton.RightMouse });
        menu.AddItem(EditorGUIUtility.TrTextContent("Debug"), false, Debug, null);
    }
    GenericMenu menu= OnGUIUtility.Components.Menu();
    protected override void RegisterCallbacksOnTarget()
    {
        target.RegisterCallback<MouseDownEvent>(OnMouseDown);
        target.RegisterCallback<MouseUpEvent>(OnMouseUp);
    }


    protected override void UnregisterCallbacksFromTarget()
    {
        target.UnregisterCallback<MouseDownEvent>(OnMouseDown);
        target.UnregisterCallback<MouseUpEvent>(OnMouseUp);
    }
    private void OnMouseDown(MouseDownEvent evt)
    {
        if (CanStartManipulation(evt))
        {
            target.CaptureMouse();
            evt.StopPropagation();
            menu.ShowAsContext();
        }
    }
    private void OnMouseUp(MouseUpEvent evt)
    {
        if (!target.HasMouseCapture() || !CanStopManipulation(evt))
            return;
        target.ReleaseMouse();
        evt.StopPropagation();
    }

    private void Debug(object obj)
    {
      //  EditorTween.Tween((e)=> { UnityEngine.Debug.Log(e); }, 3, EditorTweenCurve.BuiltinCurve.easeInOutCirc);
    }
}