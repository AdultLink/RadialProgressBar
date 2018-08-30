using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace AdultLink {
	
	[System.Serializable]
	public class CameraPositions : System.Object {

			public string name;
			public Vector3 pos;
			public Vector3 rot;
			[TextArea(0,10)]
			public string description;
		
	}

}