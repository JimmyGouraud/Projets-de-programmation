using UnityEngine;
using System.Collections;

public class Enemy : MonoBehaviour {
	GameObject pathGo;
	Transform targetPathNode;
	int pathNodeIndex = 0;

	public float speed = 3f;
	public float health = 1f;

	// Use this for initialization
	void Start () {
		pathGo = GameObject.Find ("Path");
	}

	void GetNextPathNode(){
		targetPathNode = pathGo.transform.GetChild (pathNodeIndex);
		pathNodeIndex++;
	}

	// Update is called once per frame
	void Update () {
		if (targetPathNode == null) {
			GetNextPathNode ();
			if (targetPathNode == null) {
				ReachedGoal ();
			}
		}
		Vector3 dir = targetPathNode.position - this.transform.localPosition;

		float distThisFrame = speed;// * Time.deltaTime;
		if (dir.magnitude < distThisFrame) {
			// we reached the node
			targetPathNode = null;
		} else {
			// Move Towards node
			transform.Translate(dir.normalized * distThisFrame, Space.World);
			Quaternion targetRotation = Quaternion.LookRotation (dir);
			this.transform.rotation = Quaternion.Lerp (this.transform.rotation, targetRotation, Time.deltaTime * 5);
		}
	}

	void ReachedGoal() {
		Destroy (gameObject);
	}

	public void TakeDamage(float damage){
		health -= damage;
		if (health <= 0) {
			Die ();
		}
	}

	public void Die(){
		Destroy (gameObject);
	}
}
