using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BombDefusal : MonoBehaviour {

	// Use this for initialization
	public float defusalTime = 10f;
	public GameObject bar;
	public GameObject _light;
	public TextMesh defusalText;
	public TextMesh timerText;
	private bool defusing = false;
	private string defusingString ="Defusing the bomb, no kit";
	private string notDefusingString = "Press 'T' to defuse the bomb";
	private string bombDefusedStringString = "Bomb has been defused!";
	private float defusalAmount;
	private float fillPercentage = 1f;
	private Material mat;
	void Start () {
		mat = bar.GetComponent<Renderer>().material;
		defusalAmount = Time.fixedDeltaTime / defusalTime;
	}
	
	// Update is called once per frame
	void Update () {
		if (Input.GetKeyDown(KeyCode.T)) {
			startDefusing();
			defusing = true;
		}
		else if (Input.GetKeyUp(KeyCode.T)) {
			stopDefusing();
			defusing = false;
		}
	}

	private void FixedUpdate() {
		if (defusing) {
			fillPercentage -= defusalAmount;
			fillPercentage = Mathf.Clamp(fillPercentage, 0f, 1f);
			mat.SetFloat("_Fillpercentage", fillPercentage);
			timerText.text = "00:0" + (fillPercentage*defusalTime).ToString("F3");
			if (fillPercentage <= 0f) {
				bombDefused();
			}
		}
	}

	private void stopDefusing() {
		defusalText.text = notDefusingString;
		timerText.gameObject.SetActive(false);
		bar.SetActive(false);
		_light.SetActive(false);
	}

	private void startDefusing() {
		fillPercentage = 1f;
		mat.SetFloat("_Fillpercentage", fillPercentage);
		defusalText.text = defusingString;
		timerText.gameObject.SetActive(true);
		bar.SetActive(true);
	}

	private void bombDefused() {
		timerText.gameObject.SetActive(false);
		defusalText.text = bombDefusedStringString;
		bar.SetActive(false);
		_light.SetActive(true);
	}
}
