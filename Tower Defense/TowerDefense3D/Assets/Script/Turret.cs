using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Turret : MonoBehaviour {

	Transform turretTransform;

	// Use this for initialization
	void Start () {
		turretTransform = this.transform;	
	}
	
	// Update is called once per frame
	void Update () {
		Enemy[] enemies = GameObject.FindObjectsOfType<Enemy>;

		turretTransform.Translate ((float)0.1,0,0);
	}
}
