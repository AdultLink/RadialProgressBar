using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotate : MonoBehaviour {

	// Use this for initialization
	public float rotationSpeed;

	
	// Update is called once per frame
	void FixedUpdate () {
		transform.Rotate(0f, Time.fixedDeltaTime*rotationSpeed, 0f);
	}
}
