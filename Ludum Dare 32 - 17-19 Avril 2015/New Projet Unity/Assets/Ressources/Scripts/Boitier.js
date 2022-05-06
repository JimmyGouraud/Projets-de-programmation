#pragma strict


class Boitier extends MonoBehaviour{

	var tab_go : GameObject[];
	private var boitierOn : boolean = true;
	private var sphere : Sphere;

	function Start(){
		activeBoitier();
	}

	function activeBoitier(){
		if(boitierOn == true){
			boitierOn = false;
			// Optimisation du code
			if(tab_go.Length == 1){
				sphere = tab_go[0].GetComponent(Sphere);
				sphere.sphereOn();
			}else if(tab_go.Length > 1){
				for(var sphereGo : GameObject in tab_go){
					sphere= sphereGo.GetComponent(Sphere);
					sphere.sphereOn();
				}
			}
		}else{
			boitierOn = true;
			if(tab_go.Length == 1){
				sphere = tab_go[0].GetComponent(Sphere);
				sphere.sphereOff();
			}else if(tab_go.Length > 1){
				for(var sphereGo : GameObject in tab_go){
					sphere = sphereGo.GetComponent(Sphere);
					sphere.sphereOff();
				}
			}
		}
	}
}
