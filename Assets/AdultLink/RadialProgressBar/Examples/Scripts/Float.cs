using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace AdultLink {
	
public class Float : MonoBehaviour {

	// Use this for initialization
	public float amplitude;
	public float frequency;
	private float y;
	private Vector3 initialPosition;
	private float newY;
	void Start () {
		initialPosition = transform.position;
		newY = initialPosition.y;
	}
	
	// Update is called once per frame
	void Update () {
		newY = amplitude/100*Mathf.Sin(Time.time*frequency);
		transform.position += Vector3.up*newY;
	}
}

}