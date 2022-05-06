using UnityEngine;
using System.Collections;

public class Map : MonoBehaviour {
	private GameObject[,] tab;

	// Use this for initialization
	void Start () {
		tab = new GameObject[10,20];
		float x;
		float y;
		float angle;
		float r = 2.5f;

		for (int i = 0; i < tab.GetLength(0); i++) {
			r += 1.1f;
			for (int j = 0; j < tab.GetLength(1); j++) {
				angle = 360f / tab.GetLength (1) * j;
				x = r * Mathf.Cos (convDegToRad(angle));
				y = r * Mathf.Sin (convDegToRad(angle));

				tab [i, j] = (GameObject)Instantiate (Resources.Load ("prefabs/caseTab"));
				tab [i, j].transform.position = new Vector3 (x, y, 0);
				tab [i, j].transform.rotation = Quaternion.Euler (0, 0, angle);
				tab [i, j].transform.localScale += new Vector3(0, 0.3f * i, 0);
			}
		}
	}

	private float convDegToRad(float angle){
		return angle * Mathf.PI / 180;
	}


	// Update is called once per frame
	void Update () {
	
	}
}
