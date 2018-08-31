using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class RankupBar : MonoBehaviour {

	private bool fillUp = false;
	public Material mat;
	public float fillAmount = 0.05f;
	private float fillPercentage = 0f;
	public Image[] fillImages;
	private Color defaultFillColor;
	private float maxRange;
	public Text divisionText;
	public Text leagueText;
	private float initialFillPercentage;
	void Start () {
		maxRange = mat.GetFloat("_Arcrange");
		initialFillPercentage = mat.GetFloat("_Fillpercentage");
		fillPercentage = initialFillPercentage;
		mat.SetFloat("_Fillpercentage", fillPercentage);
		defaultFillColor = fillImages[1].color;
	}

	// Update is called once per frame
	void Update () {
		if (Input.GetKeyDown (KeyCode.R)) {
			fillUp = true;
		}
		if (Input.GetKeyDown (KeyCode.D)) {
			reset();
		}
	}

	void FixedUpdate () {
		if (fillUp) {
			fillUp = false;

			//FILL UP
			fillPercentage += Random.Range(0.5f, 1.5f)*fillAmount;
			fillPercentage = Mathf.Clamp(fillPercentage, 0f, 1f);
			mat.SetFloat("_Fillpercentage", fillPercentage);

			//ACTIVATE CHECKPOINTS
			int checkpoint = (int) (fillPercentage * maxRange / 45f);
			fillImages[checkpoint].color = Color.white;
			if (checkpoint >= fillImages.Length-1) {
				divisionText.gameObject.SetActive(false);
				leagueText.text = "Challenger";
			}
			divisionText.text = "Division " + (fillImages.Length - checkpoint - 1).ToString();
		}
	}

	private void OnApplicationQuit() {
		reset();
		fillPercentage = initialFillPercentage;
		mat.SetFloat("_Fillpercentage", fillPercentage);
	}

	private void reset() {
		//RESET PERCENTAGE
		fillPercentage = 0f;
		mat.SetFloat("_Fillpercentage", fillPercentage);
		//RESET CHECKPOINTS COLOR
		for (int i = 0; i < fillImages.Length; i++) {
			fillImages[i].color = defaultFillColor;
		}
		//RESET TEXT
		leagueText.text = "Diamond";
		divisionText.gameObject.SetActive(true);
		divisionText.text = "Division 6";
	}
}