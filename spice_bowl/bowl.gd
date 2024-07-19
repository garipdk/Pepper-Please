class_name SpiceBowl
extends Node2D

signal no_more(spice_type: String)

@export
var spice_name: String = "salt"
@export
var spice_ammount: int = 100
@export
var spice_value: float = 1.

# Called when the node enters the scene tree for the first time.
func _ready():
	var bowl_position = $Sprite2D.get_rect().position
	var bowl_width = $Sprite2D.texture.get_width() * $Sprite2D.scale[0]
	%Line2D.set_point_position(0, Vector2(-bowl_width/2, 0))
	%Line2D.set_point_position(1, Vector2(0, -spice_ammount))
	%Line2D.set_point_position(2, Vector2(bowl_width/2, 0))
	
	var store: Store = get_tree().get_nodes_in_group("store_group")[0]
	store.transation_done.connect(_on_transaction)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_transaction(ammount: int, spice_type: String):
	print("transaction of" + spice_type)
	if spice_type == spice_name:
		if ammount * spice_value <= spice_ammount:
			spice_ammount -= ammount * spice_value
			%Line2D.set_point_position(1, Vector2(0, -spice_ammount))
		else:
			no_more.emit(spice_type)
			
	
