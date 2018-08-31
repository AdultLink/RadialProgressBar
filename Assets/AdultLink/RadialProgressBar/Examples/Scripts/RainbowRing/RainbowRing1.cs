using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RainbowRing1 : MonoBehaviour {

	private Material mat;
	private float initialFillPercentage;
	private float fillPercentage;
	public float fillSpeed = 0.05f;
	private Color backgroundColor;
	private Color minColor;
	private Color maxColor;
	public float hueShiftAmount = 0.2f;
	void Start () {
		mat = GetComponent<Renderer>().material;
		backgroundColor = mat.GetColor("_Backgroundfillcolor");
		minColor = mat.GetColor("_Barmincolor");
		maxColor = mat.GetColor("_Barmaxcolor");
	}
	
	// Update is called once per frame
	void FixedUpdate () {
		if (fillPercentage < 1) {
			fillPercentage += fillSpeed;
			fillPercentage = Mathf.Clamp(fillPercentage, 0f, 1f);
			mat.SetFloat("_Fillpercentage", fillPercentage);
		}
		else {
			resetCycle();
		}
	}

	private void resetCycle() {
		switchColors();
		fillPercentage = 0;
		mat.SetFloat("_Fillpercentage", fillPercentage);
	}

	private void switchColors() {
		backgroundColor = maxColor;
		minColor = backgroundColor;
		maxColor = hueShift(maxColor);
		mat.SetColor("_Backgroundfillcolor", backgroundColor);
		mat.SetColor("_Barmincolor", minColor);
		mat.SetColor("_Barmaxcolor", maxColor);
	}

	private Color hueShift(Color color) {
		float h;
		float s;
		float v;
		Color.RGBToHSV(color, out h, out s, out v);
		h += hueShiftAmount;
		h %= 1f;
		color = Color.HSVToRGB(h,s,v);
		return color;
	}
}
