using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace AdultLink
{
	
public class HealBar : MonoBehaviour {

	public Material mat;
	public float fillTime = 5f;
	public float decreaseTime = 2.5f;
	private float increaseAmount;
	private float decreaseAmount;
	private float fillPercentage;
	public Text countDowntext;

	public Color defaultTextColor;
	public Color highlightColor;
	public Text descriptionText;
	private float initialFillPercentage;
	// Use this for initialization
	
	// Update is called once per frame
	private void Start() {
		initialFillPercentage = mat.GetFloat("_Fillpercentage");
		fillPercentage = initialFillPercentage;
		mat.SetFloat("_Fillpercentage", fillPercentage);
		increaseAmount = 1f / fillTime * Time.fixedDeltaTime;
		decreaseAmount = 1f / decreaseTime * Time.fixedDeltaTime;
	}
	void FixedUpdate () {
		//IF HOLDING H
		if (Input.GetKey(KeyCode.E)) {
			//IF STILL NOT FULL
			setTextColor();
			if (fillPercentage < 1f) {
				fillPercentage += increaseAmount;
				fillPercentage = Mathf.Clamp(fillPercentage, 0f, 1f);
				mat.SetFloat("_Fillpercentage", fillPercentage);
				countDowntext.gameObject.SetActive(true);
				countDowntext.text = (fillTime * (1 - fillPercentage)).ToString("F1");
			}
			else {
				countDowntext.gameObject.SetActive(false);
			}
		}
		else {
			resetTextColor();
			if (fillPercentage > 0f) {
				countDowntext.gameObject.SetActive(true);
				fillPercentage -= decreaseAmount;
				fillPercentage = Mathf.Clamp(fillPercentage, 0f, 1f);
				mat.SetFloat("_Fillpercentage", fillPercentage);
				countDowntext.text = (fillTime * (1 - fillPercentage)).ToString("F1");
			}
			else {
				countDowntext.gameObject.SetActive(false);
			}
		}
	}

	private void setTextColor() {
		descriptionText.color = highlightColor;
	}

	private void resetTextColor() {
		descriptionText.color = defaultTextColor;
	}

	private void OnApplicationQuit() {
		mat.SetFloat("_Fillpercentage", initialFillPercentage);
	}

}

}
