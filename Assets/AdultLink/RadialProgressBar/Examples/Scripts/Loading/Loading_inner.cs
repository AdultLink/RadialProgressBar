using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Loading_inner : MonoBehaviour {

	private Material mat;
	public float rotationSpeed;
	private float rotation;
	void Start () {
		mat = GetComponent<Image>().material;
		rotation = mat.GetFloat("_Rotation");
	}
	
	// Update is called once per frame
	void FixedUpdate () {
		rotation += rotationSpeed;
		if (rotation <= 0f) {rotation = 360f;}
		else if (rotation >= 360f) {rotation = 0f;}
		mat.SetFloat("_Rotation", rotation);
	}
}
