class_name SpiceBowl
extends Node2D

signal no_more(spice_type: String)

@export var min_value: float = 0
@export var max_value: float = 1
@export var spice_name: String = "salt"
@export var init_ammount: int = 100

var spice: PepperGlobal.Spice = PepperGlobal.Spice.new(spice_name, min_value, max_value, init_ammount)

# Called when the node enters the scene tree for the first time.
func _ready():
	var bowl_position = $Sprite2D.get_rect().position
	var bowl_width = $Sprite2D.texture.get_width() * $Sprite2D.scale[0]
	%Line2D.set_point_position(0, Vector2(-bowl_width/2, 0))
	%Line2D.set_point_position(1, Vector2(0, -spice.ammount))
	%Line2D.set_point_position(2, Vector2(bowl_width/2, 0))
	
	var store: Store = get_tree().get_nodes_in_group("store_group")[0]
	store.transation_done.connect(_on_transaction)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_transaction(bargain_ammount: int, bargain_value:float, spice_type: String):
	print("transaction of" + spice_type)
	if spice_type == spice.spice_name:
		if bargain_ammount <= spice.ammount:
			spice.ammount -= bargain_ammount * bargain_value
			print(spice.ammount)
			%Line2D.set_point_position(1, Vector2(0, -spice.ammount))
		else:
			no_more.emit(spice_type)
			
	
