using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace AdultLink
{
public enum Status {
	accel,
	braking,
	idle,
}

public class SpeedBar : MonoBehaviour {

	
	public float maxSpeed = 175;
	public float accelTime = 10f;
	public float breakTime = 3f;
	public float idleTime = 20f;

	public Material mat;
	public Text speedValueText;

	//---
	private float accelAmount;
	private float breakAmount;
	private float idleAmount;

	//--
	private float fillPercentage;
	private float initialValue = 0f;

	private Status status;

	void Start() {
		fillPercentage = initialValue;
		status = Status.idle;
		accelAmount = 1f / accelTime * Time.fixedDeltaTime;
		breakAmount = 1f / breakTime * Time.fixedDeltaTime;
		idleAmount = 1f / idleTime * Time.fixedDeltaTime;
		mat.SetFloat("_Fillpercentage", fillPercentage);
		setText();
	}

	void Update()
	{
		if (Input.GetKey(KeyCode.W)) {
			status = Status.accel;
		}
		else if (Input.GetKey(KeyCode.S)) {
			status = Status.braking;
		}
		else {
			status = Status.idle;
		}
	}

	void FixedUpdate() {
		if (status == Status.accel) {
			fillPercentage += accelAmount;
		}

		else if (status == Status.braking) {
			fillPercentage -= breakAmount;
		}

		else {
			fillPercentage -= idleAmount;
		}
		fillPercentage = Mathf.Clamp(fillPercentage, 0f, 1f);
		mat.SetFloat("_Fillpercentage", fillPercentage);
		setText();
	}

	private void setText() {
		speedValueText.text = (fillPercentage*maxSpeed).ToString("F0");
	}

}

}