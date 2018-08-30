using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace AdultLink
{
public class PictureBar : MonoBehaviour {

	// Use this for initialization
	public Material mat;
	private bool takingPhoto = true;
	private float fillPercentage;

	private float initialPercentage = 1f;
	public float fillTime = 0.25f;
	private float increaseAmount;

	public Color defaultTextColor;
	public Color highlightColor;
	public Text descriptionText;

	void Start () {
		fillPercentage = initialPercentage;
		mat.SetFloat("_Fillpercentage", fillPercentage);
		increaseAmount = 1f / fillTime * Time.fixedDeltaTime;
	}
	
	// Update is called once per frame
	void Update () {
		if (!takingPhoto && Input.GetKeyDown(KeyCode.P)) {
			takingPhoto = true;
		}
	}
	void FixedUpdate()
	{
		if (takingPhoto) {
			setTextColor();
			fillPercentage += increaseAmount;
			fillPercentage = Mathf.Clamp(fillPercentage, 0f, 1f);
			mat.SetFloat("_Fillpercentage", fillPercentage);
			if (fillPercentage >= 1f) {
				fillPercentage = 0f;
				takingPhoto = false;
				resetTextColor();
			}
		}
	}

	private void setTextColor() {
		descriptionText.color = highlightColor;
	}

	private void resetTextColor() {
		descriptionText.color = defaultTextColor;
	}
}
}
