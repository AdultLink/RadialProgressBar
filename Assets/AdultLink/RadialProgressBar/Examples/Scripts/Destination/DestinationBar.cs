using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class DestinationBar : MonoBehaviour {

	// Use this for initialization
	public Material mat;
	public float maxRadius = 0.4f;
	public float minRadius = 0.2f;
	private float amplitude;
	private float offset;
	public float frequency;
	public Text descriptionText;
	private bool flashing;
	private float initialRadius;
	private float radius;
	private Color descriptionTextNormalColor;
	public Color descriptionTextHighlightColor;
	void Start () {
		initialRadius = mat.GetFloat("_Radius");
		descriptionTextNormalColor = descriptionText.color;
		radius = initialRadius;
		mat.SetFloat("_Radius", radius);
		amplitude = (maxRadius - minRadius) / 2f;
		offset = (maxRadius + minRadius) / 2f;
	}
	
	// Update is called once per frame
	void Update () {
		if (Input.GetKeyDown(KeyCode.X)) {
			flashing = !flashing;
			descriptionText.color = flashing ? descriptionTextHighlightColor : descriptionTextNormalColor;
		}
	}

	void FixedUpdate() {
		if (flashing) {
			radius = amplitude*Mathf.Sin(Time.time*frequency) + offset;
			mat.SetFloat("_Radius", radius);
		}
	}

	private void OnApplicationQuit() {
		mat.SetFloat("_Radius", initialRadius);
	}
}
