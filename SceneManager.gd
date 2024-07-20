extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	PepperGlobal.shelves = $Shelves
	add_child(load("res://map/map.tscn").instantiate())
	add_child(load("res://store/store.tscn").instantiate())
	await get_tree().process_frame
	move_child($Shelves, 2)
	$Shelves.connect_all_transations($Store)
	pass # Replace with function body.

func _input(event:InputEvent):
	if event.is_action_pressed("ui_cancel"):
		move_child($MapScene, 1)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
