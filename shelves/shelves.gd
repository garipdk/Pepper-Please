class_name Shelves
extends Node2D

var spices_nodes: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	await  get_tree().process_frame
	spices_nodes = [
	$Salt, $Laurel, $Cinnamon, $Fenugreek, $Saffron
	]
	PepperGlobal.unlocked_spice.connect(on_unlocked_spice)

func connect_all_transations(store:Store):
	$Salt.connect_transation(store)
	$Laurel.connect_transation(store)
	$Cinnamon.connect_transation(store)
	$Fenugreek.connect_transation(store)
	$Saffron.connect_transation(store)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func on_unlocked_spice():
	spices_nodes[PepperGlobal.number_of_unlocked_spices].visible = true
	
	
