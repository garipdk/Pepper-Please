class_name SpiceBowl
extends Node2D

signal no_more(spice_type: String)

@export var min_value: float = 0
@export var max_value: float = 1
@export var spice_name: String = "salt"
@export var ammount: int = 100
@export var color: Color = Color(0, 0, 1, 0)
var empty_bowl: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var bowl_width = $Sprite2D.texture.get_width() * $Sprite2D.scale[0]
	%Line2D.default_color = color
	var offset = 10
	%Line2D.set_point_position(0, Vector2(-bowl_width/2 + offset, 0))
	%Line2D.set_point_position(1, Vector2(0, -ammount))
	%Line2D.set_point_position(2, Vector2(bowl_width/2 -offset, 0))
	
	var store: Store = get_tree().get_nodes_in_group("store_group")[0]
	store.transation_done.connect(_on_transaction)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_transaction(bargain_ammount: int, spice_type: String):
	print("transaction of" + spice_type)
	if spice_type == spice_name:
		ammount -= bargain_ammount
		print(ammount)
		%Line2D.set_point_position(1, Vector2(0, -ammount))
		if ammount == 0:
			empty_bowl = true
			
	
