extends Node2D

var current_destination_map:NodePath
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	$Shelves.connect_all_transations($Store)
	$TextureRect.scale = Vector2(0.5, 0.5)
	pass # Replace with function body.

func _input(event:InputEvent):
	if event.is_action_pressed("ui_cancel"):
		move_child($MapScene, 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if PepperGlobal.canChangeScene:
		print(current_destination_map.get_name(0))
		if current_destination_map.get_name(0) == "Store":
			move_child(get_node(current_destination_map), 1)
		PepperGlobal.canChangeScene = false
		
	pass


func _on_shelves_ready():
	PepperGlobal.shelves = $Shelves
	pass # Replace with function body.



func _on_area_2d_body_entered(_body, extra_arg_0):
	current_destination_map = extra_arg_0
	pass # Replace with function body.


func _on_texture_rect_gui_input(event:InputEvent):
	if event is InputEventMouseButton and event.pressed:
		get_tree().quit()
	pass # Replace with function body.
