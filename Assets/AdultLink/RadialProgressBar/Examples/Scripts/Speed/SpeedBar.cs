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
	public float accelBrightness = 0.15f;
	public float brakeBrightness = 0.15f;
	public float lerpTime = 0.2f;
	private float interpStartTime = 0f;
	private Color targetColor;
	public Color defaultTextColor;
	public Color highlightColor;
	private float initialRotationSpeed;
	public Material mat;
	public Text speedValueText;
	public Text accelDescriptionText;
	public Text brakeDescriptionText;

	public float rotationMultiplier;
	//---
	private float accelAmount;
	private float breakAmount;
	private float idleAmount;

	//--
	private float fillPercentage;
	private float initialFillPercentage;
	private Color initialMaxColor;

	private Status status;

	void Start() {

		initialFillPercentage = mat.GetFloat("_Fillpercentage");
		initialRotationSpeed = mat.GetFloat("_Maintexrotationspeed");
		initialMaxColor = mat.GetColor("_Barmaxcolor");
		fillPercentage = initialFillPercentage;
		targetColor = initialMaxColor;
		status = Status.idle;
		accelAmount = 1f / accelTime * Time.fixedDeltaTime;
		breakAmount = 1f / breakTime * Time.fixedDeltaTime;
		idleAmount = 1f / idleTime * Time.fixedDeltaTime;
		mat.SetFloat("_Fillpercentage", fillPercentage);
		setText();
	}

	void Update()
	{
		if (Input.GetKeyDown(KeyCode.W)) {
			status = Status.accel;
			interpStartTime = Time.time;
			targetColor = shiftValue(initialMaxColor, accelBrightness);
			setRotation(rotationMultiplier);
			setTextColor(accelDescriptionText);
		}

		if (Input.GetKeyDown(KeyCode.S)) {
			status = Status.braking;
			targetColor = shiftValue(initialMaxColor, brakeBrightness);
			interpStartTime = Time.time;
			setTextColor(brakeDescriptionText);
		}

		if (Input.GetKeyUp(KeyCode.W) || Input.GetKeyUp(KeyCode.S)) {
			status = Status.idle;
			interpStartTime = Time.time;
			targetColor = initialMaxColor;
			setRotation(1f);
			resetTextColor();
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

		float elapsedTime = Time.time - interpStartTime;
		if (elapsedTime < lerpTime) {
			mat.SetColor("_Barmaxcolor", Color.Lerp(mat.GetColor("_Barmaxcolor"), targetColor, elapsedTime / lerpTime));
		}
	}

	private void setText() {
		speedValueText.text = (fillPercentage*maxSpeed).ToString("F0");
	}

	private Color shiftValue(Color color, float amount) {
		float h;
		float s;
		float v;
		Color.RGBToHSV(color, out h, out s, out v);
		v += amount;
		return Color.HSVToRGB(h,s,v);
	}

	private void setTextColor(Text text) {
		text.color = highlightColor;
	}

	private void resetTextColor() {
		brakeDescriptionText.color = defaultTextColor;
		accelDescriptionText.color = defaultTextColor;
	}

	private void setRotation(float multiplier) {
		mat.SetFloat("_Maintexrotationspeed", initialRotationSpeed*multiplier);
	}

	private void OnApplicationQuit() {
		fillPercentage = initialFillPercentage;
		mat.SetFloat("_Fillpercentage", fillPercentage);
		mat.SetColor("_Barmaxcolor", initialMaxColor);
		mat.SetFloat("_Maintexrotationspeed", initialRotationSpeed);
	}

}
}