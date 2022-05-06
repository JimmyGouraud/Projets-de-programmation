#pragma strict

class Sphere extends MonoBehaviour{

	function sphereOn(){
		// Remplacer "SpotlightSphere" par le nom de la light en question
		transform.Find("SpotlightSphere").GetComponent(Light).enabled = true;
		
	}

	function sphereOff(){
		transform.Find("SpotlightSphere").GetComponent(Light).enabled = false;
		//GetComponent(Light).enabled = false;
	}
}