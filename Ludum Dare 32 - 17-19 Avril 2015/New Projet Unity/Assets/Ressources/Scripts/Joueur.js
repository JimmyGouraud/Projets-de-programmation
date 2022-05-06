#pragma strict


class Joueur extends MonoBehaviour{
	private var go : GameObject;
	private var hit : RaycastHit;
	private var inter : Interrupteur;
	private var boitier : Boitier;
	private var winlevel : WinLevel;

	function Start () {
		winlevel = GetComponent(WinLevel);
	}

	function Update () {
		if(Input.GetMouseButtonDown(0)){
			winlevel.IncrBoitier();
			// Si il y a une collision entre la vision de la caméra et le hit à 5 de distance.
			if(Physics.Raycast(Camera.main.transform.position, Camera.main.transform.forward, hit, 5)){
				go = hit.transform.gameObject;
				if(go.tag == "TagInterrupteur"){
					inter = go.GetComponent(Interrupteur);
					inter.activeInterrupteur();
					// Highlighter.Highlight(inter);
				}
				else if(go.tag == "TagBoitier"){
					boitier = go.GetComponent(Boitier);
					boitier.activeBoitier();
				}
			}
		}
	}
}


