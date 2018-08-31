using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RainbowRing2 : MonoBehaviour {

	private Material mat;
	private float initialFillPercentage;
	private float fillPercentage;
	[Range(0f,1f)]
	public float fillSpeed = 0.5f;
	private Color backgroundColor;
	private Color minColor;
	private Color maxColor;
	public float hueShiftAmount = 0.35f;
	void Start () {
		mat = GetComponent<Renderer>().material;
		backgroundColor = mat.GetColor("_Backgroundfillcolor");
		minColor = mat.GetColor("_Barmincolor");
		maxColor = mat.GetColor("_Barmaxcolor");
	}
	
	// Update is called once per frame
	void FixedUpdate () {
		fillPercentage = Mathf.PingPong(Time.time*fillSpeed, 1f);
		mat.SetFloat("_Fillpercentage", fillPercentage);
		if (fillPercentage >= 1f) {
			resetCycleMax();
		}
		else if (fillPercentage <= 0f) {
			resetCycleMin();
		}
	}

	private void resetCycleMax() {
		backgroundColor = hueShift(backgroundColor);
		minColor = maxColor;
		mat.SetColor("_Backgroundfillcolor", backgroundColor);
		mat.SetColor("_Barmincolor", minColor);
	}

	private void resetCycleMin() {
		minColor = backgroundColor;
		maxColor = hueShift(maxColor);
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
