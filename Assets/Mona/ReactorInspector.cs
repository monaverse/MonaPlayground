#if UNITY_EDITOR
using UnityEngine;
using UnityEditor;

namespace Mona
{
    [CustomEditor(typeof(MonaReactor))]
    public class ReactorInspector : Editor
    {
        public override void OnInspectorGUI()
        {
            Texture banner = (Texture)AssetDatabase.LoadAssetAtPath("Assets/Resources/Editor/reactor.png", typeof(Texture));
            if (banner)
            {
                GUI.DrawTexture(new Rect(0, 0, 498, 66), banner, ScaleMode.ScaleToFit, false);
            }
            GUILayout.Space(60);

            base.DrawDefaultInspector();
        }
    }
}
#endif