﻿using UnityEngine;
using System.Collections;

public class Bullet : MonoBehaviour {

	public float speed = 15f;
	public Transform target;
	public float damage = 1f;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		Vector3 dir = target.position - this.transform.localPosition;

		float distThisFrame = speed;// * Time.deltaTime;
		if (dir.magnitude < distThisFrame) {
			// we reached the node
			DoBulletHit();
		} else {
			// Move Towards node
			transform.Translate(dir.normalized * distThisFrame, Space.World);
			Quaternion targetRotation = Quaternion.LookRotation (dir);
			this.transform.rotation = Quaternion.Lerp (this.transform.rotation, targetRotation, Time.deltaTime * 5);
		}
	}

	void DoBulletHit(){
		gameObject.GetComponent<Enemy> ();
		Destroy (gameObject);
	}
}
