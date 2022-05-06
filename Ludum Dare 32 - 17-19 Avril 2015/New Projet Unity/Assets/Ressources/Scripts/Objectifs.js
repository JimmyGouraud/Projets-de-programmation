#pragma strict


class Objectifs extends MonoBehaviour{
	
	var text : String;
	var x : int;
	var y : int;
	var font : Font;
	var fontsize : GUIStyle;

	function Start () {

	}

	function Update () {

	}

	function OnGUI(){
		GUI.skin.font = font;
		GUI.Label(Rect(x, y, 300, 200), text);
	}
}

