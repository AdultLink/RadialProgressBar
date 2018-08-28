using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace AdultLink
{
	
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
		mat.SetFloat("_Fillpercentage", fillPercentage);
		increaseAmount = 1f / fillTime * Time.fixedDeltaTime;
		decreaseAmount = 1f / decreaseTime * Time.fixedDeltaTime;
	}
	void FixedUpdate () {
		//IF HOLDING H
		if (Input.GetKey(KeyCode.E)) {
			//IF STILL NOT FULL
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


}

}
