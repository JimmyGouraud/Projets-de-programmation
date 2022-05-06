#pragma strict

class Projecteur extends MonoBehaviour{

	function projecteurOn(){
		// Remplacer "SpotlightProjecteur" par le nom de la light en question
		transform.Find("SpotlightProjecteur").GetComponent(Light).enabled = true;
		//GetComponent(Light).enabled = true;
	}

	function projecteurOff(){
		transform.Find("SpotlightProjecteur").GetComponent(Light).enabled = false;
		//GetComponent(Light).enabled = false;
	}
}
