using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PictureBar : MonoBehaviour {

	// Use this for initialization
	public Material mat;
	private bool takingPhoto;
	private float fillPercentage;

	private float initialPercentage = 1f;
	public float fillTime = 0.25f;
	private float increaseAmount;

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
			fillPercentage += increaseAmount;
			fillPercentage = Mathf.Clamp(fillPercentage, 0f, 1f);
			mat.SetFloat("_Fillpercentage", fillPercentage);
			if (fillPercentage >= 1f) {
				fillPercentage = 0f;
				takingPhoto = false;
			}
		}
	}
}
