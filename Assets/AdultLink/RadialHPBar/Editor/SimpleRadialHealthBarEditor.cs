using UnityEngine;
using UnityEditor;
 
public class SimpleRadialHealthBarEditor : ShaderGUI
{
	MaterialEditor _materialEditor;
	MaterialProperty[] _properties;

	//MAIN SETTINGS
	private MaterialProperty _Radius = null;
	private MaterialProperty _Arcrange = null;
	private MaterialProperty _Fillpercentage = null;
	private MaterialProperty _Globaltransparency = null;
	//MAINBAR
	private MaterialProperty _Barmincolor = null;
	private MaterialProperty _Barmaxcolor = null;

	protected static bool ShowMainSettings = true;
	protected static bool ShowMainbarSettings = true;

 	
	public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
    {
		_properties = properties;
		_materialEditor = materialEditor;
		EditorGUI.BeginChangeCheck();
		DrawGUI();
	}

	void DrawGUI() {
		GetProperties();

		startFoldout();
		ShowMainSettings = EditorGUILayout.Foldout(ShowMainSettings, "General");
		if (ShowMainSettings){
			DrawMainSettings();
		}
		endFoldout();


		startFoldout();
		ShowMainbarSettings = EditorGUILayout.Foldout(ShowMainbarSettings, "Bar color");
		if (ShowMainbarSettings){
			DrawMainbarSettings();
		}
		endFoldout();
    }

	void GetProperties() {

		//MAIN SETTINGS
		_Radius = FindProperty("_Radius", _properties);
		_Arcrange = FindProperty("_Arcrange", _properties);
		_Fillpercentage = FindProperty("_Fillpercentage", _properties);
		_Globaltransparency = FindProperty("_Globaltransparency", _properties);
		//MAINBAR
		_Barmincolor = FindProperty("_Barmincolor", _properties);
		_Barmaxcolor = FindProperty("_Barmaxcolor", _properties);

	}

	void DrawMainSettings() {
		//MAIN SETTINGS
        EditorGUI.indentLevel++;
		_materialEditor.SetDefaultGUIWidths();
		_materialEditor.ShaderProperty(_Radius, _Radius.displayName);
		_materialEditor.ShaderProperty(_Arcrange, _Arcrange.displayName);
		_materialEditor.ShaderProperty(_Fillpercentage, _Fillpercentage.displayName);
		_materialEditor.ShaderProperty(_Globaltransparency, _Globaltransparency.displayName);
		EditorGUI.indentLevel--;
	}

	void DrawMainbarSettings() {
		//GLOBAL EMISSION
        EditorGUI.indentLevel++;
		_materialEditor.SetDefaultGUIWidths();
		_materialEditor.ShaderProperty(_Barmincolor, "Min value color");
		_materialEditor.ShaderProperty(_Barmaxcolor, "Max value color");
		EditorGUI.indentLevel--;
	}

	void startFoldout() {
		EditorGUILayout.BeginVertical(EditorStyles.helpBox);
		EditorGUI.indentLevel++;
	}

	void endFoldout() {
		EditorGUI.indentLevel--;
		EditorGUILayout.EndVertical();
	}
}