class_name Shelves
extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func connect_all_transations(store:Store):
	$Salt.connect_transation(store)
	$Laurel.connect_transation(store)
	$Cinnamon.connect_transation(store)
	$Fenugreek.connect_transation(store)
	$Saffron.connect_transation(store)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

