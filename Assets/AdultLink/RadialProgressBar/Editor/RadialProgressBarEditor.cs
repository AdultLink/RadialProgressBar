using UnityEngine;
using UnityEditor;
 
namespace AdultLink
{
public class RadialProgressBarEditor : ShaderGUI
{
	MaterialEditor _materialEditor;
	MaterialProperty[] _properties;

	//MAIN SETTINGS
	private MaterialProperty _Radius = null;
	private MaterialProperty _Arcrange = null;
	private MaterialProperty _Fillpercentage = null;
	private MaterialProperty _Globalopacity = null;
	private MaterialProperty _Rotation = null;

	//MAINBAR
	private MaterialProperty _Barmincolor = null;
	private MaterialProperty _Barmaxcolor = null;
	private MaterialProperty _Mainbarborderopacity = null;
	private MaterialProperty _Barsecondarymincolor = null;
	private MaterialProperty _Barsecondarymaxcolor = null;
	private MaterialProperty _Bordermincolor = null;
	private MaterialProperty _Bordermaxcolor = null;
	private MaterialProperty _Mainborderradialwidth = null;
	private MaterialProperty _Mainbordertangentwidth = null;

	//MAIN TEX
	private MaterialProperty _Maintex = null;
	private MaterialProperty _Maintexopacity = null;
	private MaterialProperty _Maintexcontrast = null;
	private MaterialProperty _Invertmaintex = null;
	private MaterialProperty _Maintextiling = null;
	private MaterialProperty _Maintexoffset = null;
	private MaterialProperty _Maintexscrollrotate = null;
	private MaterialProperty _Maintexscrollspeed = null;
	private MaterialProperty _Maintexrotatespeed = null;

	//SECONDARY TEX
	private MaterialProperty _Secondarytex = null;
	private MaterialProperty _Secondarytexcontrast = null;
	private MaterialProperty _Secondarytexopacity = null;
	private MaterialProperty _Invertsecondarytex = null;
	private MaterialProperty _Secondarytextiling = null;
	private MaterialProperty _Secondarytexoffset = null;
	private MaterialProperty _Secondarytexscrollrotate = null;
	private MaterialProperty _Secondarytexscrollspeed = null;
	private MaterialProperty _Secondarytexrotatespeed = null;

	//NOISE TEX
	private MaterialProperty _Noisetex = null;
	private MaterialProperty _Invertnoisetex = null;
	private MaterialProperty _Noisetexcontrast = null;
	private MaterialProperty _Noiseintensity = null;
	private MaterialProperty _Noisetexspeed = null;
	private MaterialProperty _Noisetextiling = null;
	private MaterialProperty _Noisetexoffset = null;

	//BACKGROUND
	private MaterialProperty _Backgroundbordercolor = null;
	private MaterialProperty _Backgroundborderopacity = null;
	private MaterialProperty _Backgroundfillcolor = null;

	private MaterialProperty _Backgroundopacity = null;
	private MaterialProperty _Backgroundborderradialwidth = null;
	private MaterialProperty _Backgroundbordertangentwidth = null;
	

	protected static bool ShowBackgroundSettings = true;
	protected static bool ShowMainSettings = true;
	protected static bool ShowMainbarSettings = true;
	protected static bool ShowBorderSettings = true;
	protected static bool ShowFillSettings = true;
	protected static bool ShowMainTextureSettings = true;
	protected static bool ShowSecondaryTextureSettings = true;
	protected static bool ShowNoiseTextureSettings = true;
 	
	public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
    {
		_properties = properties;
		_materialEditor = materialEditor;
		EditorGUI.BeginChangeCheck();
		DrawGUI();
	}

	void GetProperties() {

		//MAIN SETTINGS
		_Radius = FindProperty("_Radius", _properties);
		_Arcrange = FindProperty("_Arcrange", _properties);
		_Fillpercentage = FindProperty("_Fillpercentage", _properties);
		_Globalopacity = FindProperty("_Globalopacity", _properties);
		_Rotation = FindProperty("_Rotation", _properties);

		//MAINBAR
		_Barmincolor = FindProperty("_Barmincolor", _properties);
		_Barmaxcolor = FindProperty("_Barmaxcolor", _properties);
		_Mainbarborderopacity = FindProperty("_Mainbarborderopacity", _properties);
		_Barsecondarymincolor = FindProperty("_Barsecondarymincolor", _properties);
		_Barsecondarymaxcolor = FindProperty("_Barsecondarymaxcolor", _properties);
		_Bordermincolor = FindProperty("_Bordermincolor", _properties);
		_Bordermaxcolor = FindProperty("_Bordermaxcolor", _properties);
		_Mainborderradialwidth = FindProperty("_Mainborderradialwidth", _properties);
		_Mainbordertangentwidth = FindProperty("_Mainbordertangentwidth", _properties);

		//MAIN TEX
		_Maintex = FindProperty("_Maintex", _properties);
		_Maintexcontrast = FindProperty("_Maintexcontrast", _properties);
		_Maintexopacity = FindProperty("_Maintexopacity", _properties);
		_Invertmaintex = FindProperty("_Invertmaintex", _properties);
		_Maintextiling = FindProperty("_Maintextiling", _properties);
		_Maintexoffset = FindProperty("_Maintexoffset", _properties);
		_Maintexscrollrotate = FindProperty("_Mainscrollrotate", _properties);
		_Maintexscrollspeed = FindProperty("_Maintexscrollspeed", _properties);
		_Maintexrotatespeed = FindProperty("_Maintexrotationspeed", _properties);

		//SECONDARY TEX
		_Secondarytex = FindProperty("_Secondarytex", _properties);
		_Secondarytexcontrast = FindProperty("_Secondarytexcontrast", _properties);
		_Invertsecondarytex = FindProperty("_Invertsecondarytex", _properties);
		_Secondarytexopacity = FindProperty("_Secondarytexopacity", _properties);
		_Secondarytextiling = FindProperty("_Secondarytextiling", _properties);
		_Secondarytexoffset = FindProperty("_Secondarytexoffset", _properties);
		_Secondarytexscrollrotate = FindProperty("_Secondaryscrollrotate", _properties);
		_Secondarytexscrollspeed = FindProperty("_Secondarytexscrollspeed", _properties);
		_Secondarytexrotatespeed = FindProperty("_Secondarytexrotationspeed", _properties);

		//NOISE TEX
		_Noisetex = FindProperty("_Noisetex", _properties);
		_Invertnoisetex = FindProperty("_Invertnoisetex", _properties);
		_Noisetexcontrast = FindProperty("_Noisetexcontrast", _properties);
		_Noiseintensity = FindProperty("_Noiseintensity", _properties);
		_Noisetexspeed = FindProperty("_Noisetexspeed", _properties);
		_Noisetextiling = FindProperty("_Noisetextiling", _properties);
		_Noisetexoffset = FindProperty("_Noisetexoffset", _properties);

		//BACKGROUND
		_Backgroundbordercolor = FindProperty("_Backgroundbordercolor", _properties);
		_Backgroundopacity = FindProperty("_Backgroundopacity", _properties);
		_Backgroundfillcolor = FindProperty("_Backgroundfillcolor", _properties);
		_Backgroundborderopacity = FindProperty("_Backgroundborderopacity", _properties);
		_Backgroundborderradialwidth = FindProperty("_Backgroundborderradialwidth", _properties);
		_Backgroundbordertangentwidth = FindProperty("_Backgroundbordertangentwidth", _properties);
	}

	static Texture2D bannerTexture = null;
    static GUIStyle title = null;
    static GUIStyle linkStyle = null;
    static string repoURL = "https://github.com/adultlink/radialprogressbar";

	void DrawBanner()
    {
        if (bannerTexture == null)
            bannerTexture = Resources.Load<Texture2D>("RadialProgressBarBanner");

        if (title == null)
        {
            title = new GUIStyle();
            title.fontSize = 20;
            title.alignment = TextAnchor.MiddleCenter;
            title.normal.textColor = new Color(1f, 1f, 1f);
        }
		

        if (linkStyle == null) linkStyle = new GUIStyle();

        if (bannerTexture != null)
        {
            GUILayout.Space(4);
            var rect = GUILayoutUtility.GetRect(0, int.MaxValue, 60, 60);
            EditorGUI.DrawPreviewTexture(rect, bannerTexture, null, ScaleMode.ScaleAndCrop);
            //
            EditorGUI.LabelField(rect, "Radial progress bar", title);

            if (GUI.Button(rect, "", linkStyle)) {
                Application.OpenURL(repoURL);
            }
            GUILayout.Space(4);
        }
    }

	void DrawGUI() {
		GetProperties();
		DrawBanner();

		startFoldout();
		ShowMainSettings = EditorGUILayout.Foldout(ShowMainSettings, "General");
		if (ShowMainSettings){
			DrawMainSettings();
		}
		endFoldout();

		startFoldout();
		ShowBackgroundSettings = EditorGUILayout.Foldout(ShowBackgroundSettings, "Background");
		if (ShowBackgroundSettings){
			DrawBackgroundSettings();
		}
		endFoldout();

		startFoldout();
		ShowMainbarSettings = EditorGUILayout.Foldout(ShowMainbarSettings, "Bar");
		if (ShowMainbarSettings){
			DrawMainbarSettings();
		}
		endFoldout();
    }

	void DrawMainSettings() {
		//MAIN SETTINGS
        EditorGUI.indentLevel++;
		_materialEditor.SetDefaultGUIWidths();
		_materialEditor.ShaderProperty(_Radius, _Radius.displayName);
		_materialEditor.ShaderProperty(_Arcrange, _Arcrange.displayName);
		_materialEditor.ShaderProperty(_Fillpercentage, _Fillpercentage.displayName);
		_materialEditor.ShaderProperty(_Globalopacity, _Globalopacity.displayName);
		_materialEditor.ShaderProperty(_Rotation, _Rotation.displayName);
		EditorGUI.indentLevel--;
	}

	void DrawBackgroundSettings() {
		//GLOBAL EMISSION
        EditorGUI.indentLevel++;
		_materialEditor.SetDefaultGUIWidths();
		_materialEditor.ShaderProperty(_Backgroundfillcolor, "Fill color");
		_materialEditor.ShaderProperty(_Backgroundopacity, "Fill opacity");
		_materialEditor.ShaderProperty(_Backgroundbordercolor, "Border color");
		_materialEditor.ShaderProperty(_Backgroundborderopacity, "Border opacity");
		_materialEditor.ShaderProperty(_Backgroundborderradialwidth, "Border radial width");
		_materialEditor.ShaderProperty(_Backgroundbordertangentwidth, "Border tangential width");
		EditorGUI.indentLevel--;
	}
	void DrawMainbarSettings() {
		//GLOBAL EMISSION
		//GUILayout.Space(3);
		_materialEditor.SetDefaultGUIWidths();

		EditorGUILayout.BeginVertical(EditorStyles.helpBox);
		ShowBorderSettings = EditorGUILayout.Foldout(ShowBorderSettings, "Border");
		if (ShowBorderSettings){
			EditorGUI.indentLevel++;
			_materialEditor.ShaderProperty(_Bordermincolor, "Color (min)");
			_materialEditor.ShaderProperty(_Bordermaxcolor, "Color (max)");
			_materialEditor.ShaderProperty(_Mainbarborderopacity, "Opacity");
			_materialEditor.ShaderProperty(_Mainborderradialwidth, "Radial width");
			_materialEditor.ShaderProperty(_Mainbordertangentwidth, "Tangential width");
			EditorGUI.indentLevel--;
		}
		EditorGUILayout.EndVertical();

		EditorGUILayout.BeginVertical(EditorStyles.helpBox);
		ShowFillSettings = EditorGUILayout.Foldout(ShowFillSettings, "Fill");
		if (ShowFillSettings){
			//MAIN TEXTURE
			EditorGUILayout.BeginVertical(EditorStyles.helpBox);
			ShowMainTextureSettings = EditorGUILayout.Foldout(ShowMainTextureSettings, "Main texture");
			if (ShowMainTextureSettings){
				EditorGUI.indentLevel++;
				_materialEditor.TexturePropertySingleLine(new GUIContent("Texture"), _Maintex);
				_materialEditor.ShaderProperty(_Barmincolor, "Color (min)");
				_materialEditor.ShaderProperty(_Barmaxcolor, "Color (max)");

				EditorGUILayout.BeginVertical(EditorStyles.helpBox);
			_materialEditor.ShaderProperty(_Maintexopacity, "Opacity");
				_materialEditor.ShaderProperty(_Maintexcontrast, "Contrast");
				_materialEditor.ShaderProperty(_Invertmaintex, "Invert");
				EditorGUILayout.EndVertical();

				EditorGUILayout.BeginVertical(EditorStyles.helpBox);
				_materialEditor.ShaderProperty(_Maintexscrollrotate, "Scroll/rotate");
				_materialEditor.ShaderProperty(_Maintexscrollspeed, "Scroll speed");
				_materialEditor.ShaderProperty(_Maintexrotatespeed, "Rotation speed");
				EditorGUILayout.EndVertical();

				EditorGUILayout.BeginVertical(EditorStyles.helpBox);
				_materialEditor.ShaderProperty(_Maintextiling, "Tiling");
				_materialEditor.ShaderProperty(_Maintexoffset, "Offset");
				EditorGUILayout.EndVertical();
				EditorGUI.indentLevel--;
			}
			EditorGUILayout.EndVertical();

			//SECONDARY TEXTURE
			EditorGUILayout.BeginVertical(EditorStyles.helpBox);
			ShowSecondaryTextureSettings = EditorGUILayout.Foldout(ShowSecondaryTextureSettings, "Secondary texture");
			if (ShowSecondaryTextureSettings){
				EditorGUI.indentLevel++;
				_materialEditor.TexturePropertySingleLine(new GUIContent("Texture"), _Secondarytex);
				_materialEditor.ShaderProperty(_Barsecondarymincolor, "Color (min)");
				_materialEditor.ShaderProperty(_Barsecondarymaxcolor, "Color (max)");

				EditorGUILayout.BeginVertical(EditorStyles.helpBox);
				_materialEditor.ShaderProperty(_Secondarytexopacity, "Opacity");
				_materialEditor.ShaderProperty(_Secondarytexcontrast, "Contrast");
				_materialEditor.ShaderProperty(_Invertsecondarytex, "Invert");
				EditorGUILayout.EndVertical();

				EditorGUILayout.BeginVertical(EditorStyles.helpBox);
				_materialEditor.ShaderProperty(_Secondarytexscrollrotate, "Scroll/rotate");
				_materialEditor.ShaderProperty(_Secondarytexscrollspeed, "Scroll speed");
				_materialEditor.ShaderProperty(_Secondarytexrotatespeed, "Rotation speed");
				EditorGUILayout.EndVertical();

				EditorGUILayout.BeginVertical(EditorStyles.helpBox);
				_materialEditor.ShaderProperty(_Secondarytextiling, "Tiling");
				_materialEditor.ShaderProperty(_Secondarytexoffset, "Offset");
				EditorGUILayout.EndVertical();
				EditorGUI.indentLevel--;


				EditorGUILayout.BeginVertical(EditorStyles.helpBox);
				//NOISE TEXTURE
				ShowNoiseTextureSettings = EditorGUILayout.Foldout(ShowNoiseTextureSettings, "Noise texture");
				if (ShowNoiseTextureSettings){
					_materialEditor.TexturePropertySingleLine(new GUIContent("Texture"), _Noisetex);
					EditorGUILayout.BeginVertical(EditorStyles.helpBox);
					_materialEditor.ShaderProperty(_Noiseintensity, "Intensity multiplier");
					_materialEditor.ShaderProperty(_Noisetexcontrast, "Contrast");
					_materialEditor.ShaderProperty(_Invertnoisetex, "Invert");
					EditorGUILayout.EndVertical();

					EditorGUILayout.BeginVertical(EditorStyles.helpBox);
					_materialEditor.ShaderProperty(_Noisetexspeed, "Scroll speed");
					_materialEditor.ShaderProperty(_Noisetextiling, "Tiling");
					_materialEditor.ShaderProperty(_Noisetexoffset, "Offset");
					EditorGUILayout.EndVertical();
				}
				EditorGUILayout.EndVertical();
				EditorGUI.indentLevel--;
			}
			EditorGUILayout.EndVertical();

		}
		EditorGUILayout.EndVertical();
		
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
}