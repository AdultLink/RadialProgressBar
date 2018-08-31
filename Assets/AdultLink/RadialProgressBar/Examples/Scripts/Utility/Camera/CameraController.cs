using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
namespace AdultLink {
	public class CameraController : MonoBehaviour {
		
		public float movementSpeed = 1f;
		public float rotationSpeed = 10f;
		public float smoothTime = 0.3f;
		public Text nameText;
		public Text indexText;
		public Text descriptionText;
		public CameraPositions[] cameraPositions;
		private int positionIndex = 0;
		private Vector3 velocity = Vector3.zero;
		private Vector3 targetPos;
		private Vector3 targetRot;
		// Use this for initialization
		void Start () {
			setPosition();
			transform.position = targetPos;
			transform.rotation = Quaternion.Euler(targetRot);
		}
		
		// Update is called once per frame
		void Update () {

			if (Input.GetKeyDown(KeyCode.LeftArrow)) {
				prevItem();
			}

			if (Input.GetKeyDown(KeyCode.RightArrow)) {
				nextItem();
			}

			//SMOOTH MOVEMENT TO THE DESIRED POSITION
			transform.position = Vector3.SmoothDamp(transform.position, targetPos, ref velocity, smoothTime);
			transform.rotation = Quaternion.RotateTowards(transform.rotation, Quaternion.Euler(targetRot), Time.deltaTime* rotationSpeed);
		}

		public void prevItem() {
			positionIndex -= 1;
			if (positionIndex < 0) positionIndex = cameraPositions.Length-1;
			setPosition();
		}

		public void nextItem() {
			positionIndex += 1;
			if (positionIndex >= cameraPositions.Length) positionIndex = 0;
			setPosition();
		}

		private void setPosition() {
			targetPos = cameraPositions[positionIndex].pos;
			targetRot = cameraPositions[positionIndex].rot;
			setInfo();
		}

		private void setInfo() {
			nameText.text = cameraPositions[positionIndex].name.ToString();
			indexText.text = (positionIndex+1).ToString() + "/" + cameraPositions.Length.ToString();
			descriptionText.text = cameraPositions[positionIndex].description.ToString();
		}

	}
}

