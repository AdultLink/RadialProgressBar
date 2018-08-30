using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public enum LoadingStatus {
	filling,
	waitingAfterTarget,
	waitingAfterFilled,
	increasingRadius,
	waitingAfterRadius,
	shrinking,
	waitingAfterShrinking,
}
public class Loading : MonoBehaviour {

	private Material mat;
	public Transform loadingBar;
	public GameObject loadingBar_inner;
	public GameObject loadingText;
	private float fillPercentage = 0;
	public float fillAmount = 0.05f;
	public float fillSpeed = 0.05f;
	private LoadingStatus status;
	private bool targetReached = true;
	private float target;
	public float targetReachedWaitTime = 0.5f;
	private float targetReachedTime = 0f;
	public float barFilledWaitTime = 1f;
	private float barFilledTime = 0f;
	public float radiusSpeed = 0.05f;
	private float radiusReachedTime = 0f;
	public float radiusReachedWaitTime = 0f;
	private float radius;
	private float initialRadius;
	public float scaleSpeed = 0.05f;
	public float scaleThreshold = 0.001f;
	private float shrunkTime = 0f;
	public float shrunkWaitTime = 2f;
	private Vector3 initialScale;
	private Vector3 scale;
	private float initialGlobalOpacity;
	private float initialFillpercentage;
	void Start () {
		loadingBar_inner.SetActive(true);
		loadingText.SetActive(true);
		mat = loadingBar.GetComponent<Image>().material;
		initialFillpercentage = mat.GetFloat("_Fillpercentage");
		initialGlobalOpacity = mat.GetFloat("_Globalopacity");
		initialScale = loadingBar.localScale;
		scale = initialScale;
		status = LoadingStatus.filling;
		initialRadius = mat.GetFloat("_Radius");
		radius = initialRadius;
		mat.SetFloat("_Fillpercentage", fillPercentage);
		target = fillPercentage + Random.Range(0.2f, 1.5f)*fillAmount;
	}
	
	// Update is called once per frame
	void FixedUpdate () {
		//IF WE ARE FILLING
		if (status == LoadingStatus.filling){
			//IF WE STILL DIDNT FILL THE FULL BAR
			if (fillPercentage < 1f) {
				//STILL IN PROGRESS
				if (!targetReached) {
					fillPercentage += fillSpeed;
					fillPercentage = Mathf.Clamp(fillPercentage, 0f, target);
					mat.SetFloat("_Fillpercentage", fillPercentage);
					if (fillPercentage >= target) {
						status = LoadingStatus.waitingAfterTarget;
						targetReachedTime = Time.time;
						targetReached = true;
					}
				}
				//TARGET REACHED
				else {
					target = fillPercentage + Random.Range(0.2f, 1.5f)*fillAmount;
					target = Mathf.Clamp(target, 0f, 1f);
					targetReached = false;
				}
			}
			//BAR IS FULL
			else {
				barFilledTime = Time.time;
				status = LoadingStatus.waitingAfterFilled;
			}
		}

		else if (status == LoadingStatus.waitingAfterTarget) {
			if (Time.time - targetReachedTime > targetReachedWaitTime) {
				status = LoadingStatus.filling;
			}
		}

		else if (status == LoadingStatus.waitingAfterFilled) {
			if (Time.time - barFilledTime > barFilledWaitTime) {
				status = LoadingStatus.increasingRadius;
			}
		}

		else if (status == LoadingStatus.waitingAfterRadius) {
			if (Time.time - radiusReachedTime > radiusReachedWaitTime) {
				status = LoadingStatus.shrinking;
			}
		}

		else if (status == LoadingStatus.increasingRadius) {
			if (radius < 1f) {
				radius += radiusSpeed;
				radius = Mathf.Clamp(radius, 0f, 1f);
				mat.SetFloat("_Radius", radius);
			}
			else {
				loadingBar_inner.SetActive(false);
				loadingText.SetActive(false);
				radiusReachedTime = Time.time;
				status = LoadingStatus.waitingAfterRadius;
			}
		}

		else if (status == LoadingStatus.shrinking) {
			scale.Scale(Vector3.one*(1-scaleSpeed));
			scale = new Vector3(Mathf.Clamp(scale.x, 0f, initialScale.x), Mathf.Clamp(scale.y, 0f, initialScale.y), Mathf.Clamp(scale.z, 0f, initialScale.z));
			loadingBar.localScale = scale;
			mat.SetFloat("_Globalopacity", scale.x/initialScale.x);
			if (Vector3.Magnitude(scale) < scaleThreshold) {
				status = LoadingStatus.waitingAfterShrinking;
				shrunkTime = Time.time;
			}
		}

		else if (status == LoadingStatus.waitingAfterShrinking) {
			if (Time.time - shrunkTime > shrunkWaitTime) {
				reset();
			}
		}
	}

	private void OnApplicationQuit() {
		reset();
		fillPercentage = initialFillpercentage;
		mat.SetFloat("_Fillpercentage", fillPercentage);
	}
	private void reset() {
		target = fillPercentage + Random.Range(0.2f, 1.5f)*fillAmount;
		fillPercentage = 0f;
		mat.SetFloat("_Fillpercentage", fillPercentage);
		loadingBar_inner.SetActive(true);
		loadingText.SetActive(true);
		mat.SetFloat("_Globalopacity", initialGlobalOpacity);
		scale = initialScale;
		loadingBar.localScale = scale;
		radius = initialRadius;
		mat.SetFloat("_Radius", radius);
		status = LoadingStatus.filling;
	}
}
