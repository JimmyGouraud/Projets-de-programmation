using UnityEngine;
using System.Collections;

public class Movement : MonoBehaviour {
	public float speed = 525F;
	private Vector3 moveDirection = Vector3.zero;

	void Update() {
		CharacterController controller = GetComponent<CharacterController>();
		if (controller.isGrounded) {
			moveDirection = new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical"));
			moveDirection = transform.TransformDirection(moveDirection);
			moveDirection *= speed;
		}
		controller.Move(moveDirection * Time.deltaTime);
	}
}
