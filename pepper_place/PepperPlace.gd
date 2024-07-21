extends Node2D
var isAlreadyThere:bool = false 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_scene_manager_child_order_changed():
	if get_index() == 3:
		$Accept.visible = true
		if not isAlreadyThere:
			isAlreadyThere = true
			$PanelContainer/Label.text = PepperGlobal.dialogs.get("pepperlab", {}).get("first_visit", "")
		else:
			$PanelContainer/Label.text = PepperGlobal.dialogs.get("pepperlab", {}).get("next_visits", "")
				
		
		
	pass # Replace with function body.


func _on_accept_pressed():
	if PepperGlobal.money < 100000:
		$Accept.visible = false
		$PanelContainer/Label.text = PepperGlobal.dialogs.get("pepperlab", {}).get("response", "")
	pass # Replace with function body.
