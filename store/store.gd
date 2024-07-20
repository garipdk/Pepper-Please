class_name Store
extends Node2D

var number_of_unlocked_spices: int = 0
var rng = RandomNumberGenerator.new()
var money: int = 50
signal transation_done(int, String)
var transaction: Dictionary
var list_spices: Array[SpiceBowl]

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	list_spices = [PepperGlobal.shelves.get_node("Salt"), PepperGlobal.shelves.get_node("Laurel"),
	PepperGlobal.shelves.get_node("Cinnamon"), PepperGlobal.shelves.get_node("Fenugreek"), PepperGlobal.shelves.get_node("Saffron")]	
	transaction = new_transaction(list_spices)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func new_transaction(list_spices):
	if are_all_bowls_empty():
		$PanelContainer/Dialog.text = "Ow oh! \n There's no more spices to sell here. Maybe I should explore a bit around?"
		$Accept.visible = false
		$Bargain.visible = false
		return {}
	var rand_spice_number: int = rng.randi_range(0, number_of_unlocked_spices)
	var spice_bowl: SpiceBowl = list_spices[rand_spice_number]
	var ammount: int = rng.randi_range(1, spice_bowl.ammount)
	var bargain_value: int = rng.randi_range(spice_bowl.min_value, spice_bowl.max_value)
	# TODO: add png in text 
	$PanelContainer/Dialog.text = "Hey, I'd like to buy {ammount}g of ".format({"ammount": ammount})
	$PanelContainer/Dialog.push_color(spice_bowl.color)
	$PanelContainer/Dialog.add_text("{spice_name} ".format({"spice_name": spice_bowl.spice_name}))
	$PanelContainer/Dialog.push_color(Color("white"))
	$PanelContainer/Dialog.add_text("for {value} gold nuggets.".format({"value": ammount*bargain_value}))
	return {"spice_name": spice_bowl.spice_name,
			"ammount_sold": ammount,
			"gold_gained": ammount * bargain_value
			}
	
func do_transaction(transaction: Dictionary):
	money += transaction.gold_gained
	PepperGlobal.shelves.get_node("GoldCounter").text = str(money)
	transation_done.emit(transaction.ammount_sold, transaction.spice_name)

func _on_accept_pressed():
	do_transaction(transaction)
	transaction = new_transaction(list_spices)
	
func are_all_bowls_empty():
	var empty_spices: Array[bool]
	for i in range(0, number_of_unlocked_spices+1):
		var spice = list_spices[i]
		empty_spices.append(spice.empty_bowl)
	if not false in empty_spices:
		return true

func _on_bargain_pressed():
	$BargainMinigame.visible = true
