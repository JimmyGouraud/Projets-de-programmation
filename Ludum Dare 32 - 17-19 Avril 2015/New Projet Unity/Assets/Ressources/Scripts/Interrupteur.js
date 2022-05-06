#pragma strict


class Interrupteur extends MonoBehaviour{

	var tab_go : GameObject[];
	private var interrupteurOn : boolean = true;
	private var projecteur : Projecteur;

	function Start() {
		activeInterrupteur();
		// gameObject.AddComponent(Light);
		// GetComponent(Light).type = LightType.Spot;
		// gameObject.GetComponent(Light).intensity = 0.2;
		// gameObject.GetComponent(Light).range = 3;
	}

	function activeInterrupteur(){
		if(interrupteurOn == true){
			interrupteurOn = false;
			// Optimisation du code				
			if(tab_go.Length == 1){
				projecteur = tab_go[0].GetComponent(Projecteur);
				projecteur.projecteurOn();
			}else if(tab_go.Length > 1){
				for(var projecteurGo : GameObject in tab_go){
					projecteur = projecteurGo.GetComponent(Projecteur);
					projecteur.projecteurOn();
				}
			}
		}else{
			interrupteurOn = true;
			if(tab_go.Length == 1){
				projecteur = tab_go[0].GetComponent(Projecteur);
				projecteur.projecteurOff();
			}else if(tab_go.Length > 1){
				for(var projecteurGo : GameObject in tab_go){
					projecteur = projecteurGo.GetComponent(Projecteur);
					projecteur.projecteurOff();
				}
			}
		}
	}
}

