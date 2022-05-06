#pragma strict

class WinLevel extends MonoBehaviour{

	private var nombreBoitier : int;
	private var cptBoitierDesactiver : int;
	private var goBoitiers : GameObject[];
	private var randomImage : int;
	var tab_RectTransform : RectTransform[];

	function Start () {
		cptBoitierDesactiver = 0;
		goBoitiers = GameObject.FindGameObjectsWithTag("Switch");
		nombreBoitier = goBoitiers.Length;
		for(var image : GameObject in tab_RectTransform)
			image.gameObject.SetActive(false);
	}

	function IncrBoitier () {
		cptBoitierDesactiver += 1;
		if(cptBoitierDesactiver == nombreBoitier){
			randomImage = Random.Range(1, tab_RectTransform.Length);
			tab_RectTransform[randomImage].gameObject.SetActive(true);
			Application.LoadLevel(Application.loadedLevel + 1);
		}
	}
}

/*
#pragma strict

class WinLevel extends MonoBehaviour{

	private var nombreBoitier : int;
	private var cptBoitierDesactiver : int;
	private var goBoitiers : GameObject[];
	var imageVictoire : RectTransform;

	function Start () {
		cptBoitierDesactiver = 0;
		goBoitiers = GameObject.FindGameObjectsWithTag("Switch");
		nombreBoitier = goBoitiers.Length;
		imageVictoire.gameObject.SetActive(false);
	}

	function IncrBoitier () {
		cptBoitierDesactiver += 1;
		if(cptBoitierDesactiver == nombreBoitier){
			imageVictoire.gameObject.SetActive(true);
			Application.LoadLevel(Application.loadedLevel + 1);
		}
	}
}
*/


