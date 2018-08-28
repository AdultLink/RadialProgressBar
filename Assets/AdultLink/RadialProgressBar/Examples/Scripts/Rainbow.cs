using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public enum StripStatus {
	filling,
	filled,
	shrinking,
	waiting,
}
public class Rainbow : MonoBehaviour {

	// Use this for initialization
	public RainbowStrip[] strips;
	private StripStatus stripStatus;
	private float timeFilled = 0f;
	private float timeShrunk = 0f;
	public float fillTime = 3f;
	public float waitTime = 3f;
	private int fillCount = 0;
	private int shrinkCount = 0;
	void Start () {
		stripStatus = StripStatus.filled;
	}
	
	// Update is called once per frame
	void Update () {
		
		if (stripStatus == StripStatus.filled) {
			if (Time.time - timeFilled >= fillTime) {
				startShrinkSequence();
			}
		}

		if (stripStatus == StripStatus.waiting) {
			if (Time.time - timeShrunk >= waitTime) {
				startFillSequence();
			}
		}
	}

	private void startFillSequence() {
		stripStatus = StripStatus.filling;
		for (int i = 0; i < strips.Length; i++) {
			strips[i].startFillSequence();
		}
	}

	private void startShrinkSequence() {
		stripStatus = StripStatus.shrinking;
		for (int i = 0; i < strips.Length; i++) {
			strips[i].startShrinkSequence();
		}
	}

	public void reportFilled() {
		fillCount++;
		if (fillCount >= strips.Length) {
			fillCount = 0;
			stripStatus = StripStatus.filled;
			timeFilled = Time.time;
		}
	}

	public void reportShrunk() {
		shrinkCount++;
		if (shrinkCount >= strips.Length) {
			shrinkCount = 0;
			stripStatus = StripStatus.waiting;
			timeShrunk = Time.time;
		}
	}
}
