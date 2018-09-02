using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class Clock : MonoBehaviour {

	public Material hourMat;
	public Material minuteMat;
	public Material secondMat;
	public TextMesh hourText;
	public TextMesh minuteText;
	// Use this for initialization
	private int prevSecond;
	private float initialHourPerc;
	private float initialMinutePerc;
	private float initialSecondPerc;
	void Start () {
		initialHourPerc = hourMat.GetFloat("_Fillpercentage");
		initialMinutePerc = minuteMat.GetFloat("_Fillpercentage");
		initialSecondPerc = secondMat.GetFloat("_Fillpercentage");
		prevSecond = System.DateTime.Now.Second;
		setHour();
		setMinute();
		secondMat.SetFloat("_Fillpercentage", System.DateTime.Now.Second/60f);
	}
	
	// Update is called once per frame 
	void FixedUpdate () {
		   int currentSecond = System.DateTime.Now.Second;
		   if (currentSecond != prevSecond) {
			   secondMat.SetFloat("_Fillpercentage", currentSecond/60f);
			   prevSecond = currentSecond;
			   if (currentSecond == 0) {
					setHour();
			   }
		   }
	}

	private int setMinute () {
		int currentMinute = System.DateTime.Now.Minute;
		minuteMat.SetFloat("_Fillpercentage", currentMinute/60f);
		string minuteString = "";
		if (currentMinute < 10) {
			minuteString = "0";
		}
		minuteText.text = minuteString + currentMinute.ToString();
		return currentMinute;
	}

	private void setHour() {
		float hourPortion = setMinute()/60f;
		int currentHour = System.DateTime.Now.Hour;
		hourMat.SetFloat("_Fillpercentage", (hourPortion+currentHour%12)/12f);
		string hourString = "";
		if (currentHour < 10) {
			hourString = "0";
		}
		hourText.text = hourString + currentHour.ToString();
	}

	private void OnApplicationQuit() {
		hourMat.SetFloat("_Fillpercentage", initialHourPerc);
		minuteMat.SetFloat("_Fillpercentage", initialMinutePerc);
		secondMat.SetFloat("_Fillpercentage", initialSecondPerc);
	}

	private void OnApplicationFocus(bool focusStatus) {
		setHour();
		setMinute();
	}
}
