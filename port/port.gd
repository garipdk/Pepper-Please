extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	await  get_tree().process_frame
	$PanelContainer/Label.text = PepperGlobal.dialogs.get("boat").get("first_visit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
