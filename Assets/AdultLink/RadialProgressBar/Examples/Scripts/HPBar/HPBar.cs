using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HPBar : MonoBehaviour {

	private Material mat;
	private float fillPercentage;
	private float initialFillPercentage;
	public int maxValue = 100;
	public TextMesh textField;
	[Range(0f,1f)]
	public float fillSpeed = 1f;
	void Start () {
		mat = GetComponent<Renderer>().material;
		initialFillPercentage = mat.GetFloat("_Fillpercentage");
		fillPercentage = initialFillPercentage;
		mat.SetFloat("_Fillpercentage", fillPercentage);
	}
	
	void FixedUpdate () {
		fillPercentage = Mathf.PingPong(Time.time*fillSpeed, 1f);
		mat.SetFloat("_Fillpercentage", fillPercentage);
		textField.text = ((int) (fillPercentage*maxValue)).ToString() + "/" + maxValue.ToString();
	}

	private void OnApplicationQuit() {
		mat.SetFloat("_Fillpercentage", initialFillPercentage);
	}
}
