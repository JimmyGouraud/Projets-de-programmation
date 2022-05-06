#pragma strict

class Sphere2 extends MonoBehaviour{

	private var avant : boolean = true;
	private var oldTime : int = Time.time;

	function Start () {

	}

	function Update () {		
		if(avant)
			transform.position += new Vector3(0.01f, 0.0f, 0.1f);
		else
			transform.position -= new Vector3(0.1f, 0.0f, 0.1f);
		if(Time.time - oldTime > 1){
			avant = !avant;
			oldTime = Time.time;
			transform.Rotate(180.0f, 0.0f, 0.0f);
		}
	}
}