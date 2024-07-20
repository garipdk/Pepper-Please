class_name Store
extends Node2D

var list_spices: Dictionary = {
	SALT = "salt",
	LAUREL = "laurel",
	CINNAMON = "cinnamon",
	FENUGREEK = "fenugreek",
	SAFFRON = "saffron"
}

var money: int = 0
signal transation_done(int, float, String)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func do_transaction(amount: int, bargain_value:float, spice_type: String):
	money += amount
	$Label.text = str(money)
	transation_done.emit(amount, bargain_value, spice_type)

func _on_button_pressed():
	do_transaction(10, 1, "salt")
