extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():

	await  get_tree().process_frame
	$PanelContainer/Label.text = PepperGlobal.dialogs.get("intro", "")
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_map_place_mouse_control_gui_input(event:InputEvent, extra_arg_0:NodePath):
	if event is InputEventMouseButton:
		$Path2D.curve.clear_points()
		$Path2D.curve.add_point($Path2D/PathFollow2D/MapPlayer.global_position)
		$Path2D/PathFollow2D/MapPlayer.position = Vector2(0,0)
		var current_node = get_node(extra_arg_0)
		print(current_node.pos)
		$Path2D.curve.add_point(current_node.pos)
		$Path2D/PathFollow2D.progress_ratio = 0.
		$Path2D/PathFollow2D.loop = false
		$Path2D/PathFollow2D.is_moving = true
		$PanelContainer.visible = false
	pass # Replace with function body.


func _on_label_visibility_changed():
	if not $PanelContainer.visible:
		$Timer.queue_free()
		$Store/MapPlaceMouseControl/Arrow.visible = false
	pass # Replace with function body.
