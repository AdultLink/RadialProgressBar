using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class HealBar : MonoBehaviour {

	public Material mat;
	private float initialHP = 0f;
	public float fillTime = 5f;
	public float decreaseTime = 2.5f;
	private float increaseAmount;
	private float decreaseAmount;
	private float fillPercentage;
	public Text countDowntext;
	// Use this for initialization
	
	// Update is called once per frame
	private void Start() {
		fillPercentage = initialHP;
		increaseAmount = 1f / fillTime * 0.02f;
		decreaseAmount = 1f / decreaseTime * 0.02f;
	}
	void FixedUpdate () {
		if (Input.GetKey(KeyCode.H) && fillPercentage != 1f) {
			fillPercentage += increaseAmount;
			fillPercentage = Mathf.Clamp(fillPercentage, 0f, 1f);
			mat.SetFloat("_Fillpercentage", fillPercentage);
			countDowntext.text = (fillTime * (1 - fillPercentage)).ToString("F1");
		}
		else {
			if (fillPercentage != 0f) {
				fillPercentage -= decreaseAmount;
				fillPercentage = Mathf.Clamp(fillPercentage, 0f, 1f);
				mat.SetFloat("_Fillpercentage", fillPercentage);
				countDowntext.text = (fillTime * (1 - fillPercentage)).ToString("F1");
			}
		}
	}


}
