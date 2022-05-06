using UnityEngine;
using System.Collections;

public class Tower : MonoBehaviour {

	Transform turretTransform;

	float range = 10f;
	public GameObject bulletPrefab;

	float fireCooldown = 0.5f;
	float fireCooldownLeft = 0;

	// Use this for initialization
	void Start () {
		turretTransform = transform.Find ("Turret");
	}
	
	// Update is called once per frame
	void Update () {
		Enemy[] enemies = GameObject.FindObjectsOfType<Enemy> ();
		Enemy nearestEnemy = null;
		float dist = Mathf.Infinity;

		foreach (Enemy e in enemies) {
			float d = Vector3.Distance (this.transform.position, e.transform.position);
			if (nearestEnemy == null || d < dist) {
				nearestEnemy = e;
				dist = d;
			}
		}

		if(nearestEnemy ==  null){
			Debug.Log("No enemies?");
			return;
		}
		Vector3 dir = nearestEnemy.transform.position - this.transform.position;

		Quaternion lookRot = Quaternion.LookRotation (dir);
		turretTransform.rotation = Quaternion.Euler (0, lookRot.eulerAngles.y, 0);

		fireCooldownLeft -= Time.deltaTime;
		if (fireCooldownLeft <= 0) {
			fireCooldownLeft = fireCooldown;
			ShootAt (nearestEnemy);
		}
	}

	void ShootAt(Enemy e) {
		GameObject bulletGO = (GameObject)Instantiate(bulletPrefab, this.transform.position, this.transform.rotation);
		Bullet b = bulletGO.GetComponent<Bullet> ();
		b.target = e.transform;

	}
}
