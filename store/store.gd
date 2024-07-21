class_name Store
extends Node2D

var rng = RandomNumberGenerator.new()
signal transation_done(int, String)
var transaction: Dictionary
var list_spices: Array[SpiceBowl]
var multiplier: float = 1

var bargain_value: int
var new_value: int
var ammount: int
var empty_spices: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	list_spices = [PepperGlobal.shelves.get_node("Salt"), PepperGlobal.shelves.get_node("Laurel"),
	PepperGlobal.shelves.get_node("Cinnamon"), PepperGlobal.shelves.get_node("Fenugreek"), PepperGlobal.shelves.get_node("Saffron")]	
	transaction = new_transaction(list_spices)
	$BargainMinigame/Sprite2D/BargainButton.disabled = true
	$BargainMinigame.bargain_done.connect(_on_bargain_done)
	PepperGlobal.unlocked_spice.connect(_on_new_spice)

	
func new_transaction(list_spices):
	if are_all_bowls_empty():
		$PanelContainer/Dialog.text = "Ow oh! \n There's no more spices to sell here. Maybe I should explore a bit around?"
		$Accept.visible = false
		$Bargain.visible = false
		return {}
	$Bargain.visible = true
	$Accept.visible = true
	multiplier = 1
	var rand_spice_number: int = rng.randi_range(0, PepperGlobal.number_of_unlocked_spices)
	var spice_bowl: SpiceBowl = list_spices[rand_spice_number]
	ammount = rng.randi_range(1, spice_bowl.ammount)
	bargain_value = rng.randi_range(spice_bowl.min_value, spice_bowl.max_value)
	# TODO: add png in text 
	$PanelContainer/Dialog.text = "Hey, I'd like to buy {ammount}g of ".format({"ammount": ammount})
	$PanelContainer/Dialog.push_color(spice_bowl.color)
	$PanelContainer/Dialog.add_text("{spice_name} ".format({"spice_name": spice_bowl.spice_name}))
	$PanelContainer/Dialog.push_color(Color("white"))
	$PanelContainer/Dialog.add_text("for {value} gold nuggets.".format({"value": ammount*bargain_value}))
	return {"spice_name": spice_bowl.spice_name,
			"ammount_sold": ammount,
			"gold_gained": roundi(ammount * bargain_value * multiplier)
			}
	
func do_transaction(transaction: Dictionary):
	PepperGlobal.money += transaction.gold_gained
	PepperGlobal.shelves.get_node("GoldCounter").text = str(PepperGlobal.money)
	transation_done.emit(transaction.ammount_sold, transaction.spice_name)

func _on_accept_pressed():
	PepperGlobal.money_changed.emit()
	do_transaction(transaction)
	transaction = new_transaction(list_spices)
	
func _on_new_spice():
	transaction = new_transaction(list_spices)
	
func are_all_bowls_empty():
	var empty_spices: Array[bool]
	for i in range(0, PepperGlobal.number_of_unlocked_spices+1):
		var spice = list_spices[i]
		empty_spices.append(spice.empty_bowl)
	if not false in empty_spices:
		return true

func _on_bargain_pressed():
	$PanelContainer/Dialog.add_text("You don't think this is a fair price? Let me inspect the spices a bit more...")
	$Bargain.visible = false
	$Accept.visible = false
	$BargainMinigame.visible = true
	$BargainMinigame.is_moving = true
	$BargainMinigame/Sprite2D/BargainButton.disabled = false
	
func _on_bargain_done(bargain_multiplier):
	$Accept.visible = true
	multiplier = bargain_multiplier
	new_value = roundi(ammount * bargain_value * multiplier)
	if multiplier > 1:
		$PanelContainer/Dialog.add_text("Arf, sure... You're right. This sould be {new_value} golds.".format({"new_value":new_value}))
	elif multiplier <= 1:
		$PanelContainer/Dialog.add_text("Ahah nope! This looks so bland. I won't give more than {new_value} golds.".format({"new_value":new_value}))
	$BargainMinigame.visible = false
	
	
