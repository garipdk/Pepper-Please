extends Node2D

var spices_colors: Array[Color] = [
	Color("#2e5f61"),
	Color("#8a6049"),
	Color("#c99314"),
	Color("#cc1d1d")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	await  get_tree().process_frame
	$PanelContainer/Label.text = PepperGlobal.dialogs.get("boat").get("first_visit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_texture_button_pressed():
	if money > 
