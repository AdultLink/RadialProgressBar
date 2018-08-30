using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RainbowStrip : MonoBehaviour {

	private StripStatus stripStatus;
	private Material mat;
	public float fillSpeed = 5f;
	private float fillPercentage = 0f;
	private Vector3 initialScale;
	private Vector3 scale;
	public float scaleAmount = 0.15f;
	public float scaleThreshold = 0.1f;
	public Rainbow rainbowController;

	void Start()
	{
		fillSpeed /= 1000;
		mat = GetComponent<Renderer>().material;
		initialScale = transform.localScale;
		scale = initialScale;
		stripStatus = StripStatus.filled;
	}
	void FixedUpdate() {

		if (stripStatus == StripStatus.filling) {
			fillPercentage += fillSpeed;
			fillPercentage = Mathf.Clamp(fillPercentage, 0f, 1f);
			mat.SetFloat("_Fillpercentage", fillPercentage);
			if (fillPercentage >= 1f) {
				stripStatus = StripStatus.filled;
				rainbowController.reportFilled();
			}
		}

		else if (stripStatus == StripStatus.shrinking) {

			scale.Scale(Vector3.one*(1-scaleAmount));
			scale = new Vector3(Mathf.Clamp(scale.x, 0f, initialScale.x), Mathf.Clamp(scale.y, 0f, initialScale.y), Mathf.Clamp(scale.z, 0f, initialScale.z));
			transform.localScale = scale;
			mat.SetFloat("_Globalopacity", scale.x/initialScale.x);
			if (Vector3.Magnitude(scale) < scaleThreshold) {
				stripStatus = StripStatus.waiting;
				rainbowController.reportShrunk();
			}
		}
	}

	public void startFillSequence() {
		fillPercentage = 0;
		mat.SetFloat("_Globalopacity", 1f);
		mat.SetFloat("_Fillpercentage", 0f);
		scale = initialScale;
		transform.localScale = scale;
		stripStatus = StripStatus.filling;
	}

	public void startShrinkSequence() {
		stripStatus = StripStatus.shrinking;
	}
}
