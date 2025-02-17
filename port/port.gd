class_name Port
extends Node2D

var already_poor: bool = false

var spices_colors: Array[Color] = [
	Color("#2e5f61"),
	Color("#8a6049"),
	Color("#c99314"),
	Color("#cc1d1d")
]

var spices_names = [
	"laurel", "cinnamon", "fenugreek", "saffron"
]

var spices_price = [
	500, 1000, 5000, 10000, 1000000
]

# Called when the node enters the scene tree for the first time.
func _ready():
	await  get_tree().process_frame
	update_text()
	
func update_text():
	$PanelContainer/RichTextLabel.text = ""
	$PanelContainer/RichTextLabel.text = PepperGlobal.dialogs.get("boat").get("first_visit")
	$PanelContainer/RichTextLabel.add_text("Today I found some ")
	$PanelContainer/RichTextLabel.push_color(spices_colors[PepperGlobal.number_of_unlocked_spices])
	$PanelContainer/RichTextLabel.add_text(" {next_spice}".format({"next_spice": spices_names[PepperGlobal.number_of_unlocked_spices]}))
	$PanelContainer/RichTextLabel.push_color("white")
	$PanelContainer/RichTextLabel.add_text(". I can sell that to yerr for {price} gold nuggets.".format({"price": spices_price[PepperGlobal.number_of_unlocked_spices]}))
	$SpicePile.modulate = spices_colors[PepperGlobal.number_of_unlocked_spices]

func _on_texture_button_pressed():
	if PepperGlobal.money >= spices_price[PepperGlobal.number_of_unlocked_spices]:
		PepperGlobal.money -= spices_price[PepperGlobal.number_of_unlocked_spices]
		PepperGlobal.number_of_unlocked_spices += 1
		PepperGlobal.unlocked_spice.emit()
		PepperGlobal.money_changed.emit()
		
		print("unlocked spice")
		already_poor = false
		if PepperGlobal.number_of_unlocked_spices == 3:
			$PanelContainer/RichTextLabel.text = ""
			$PanelContainer/RichTextLabel.text = "Arrrrgl, you got everything I could find on the world!"
			$TextureButton.visible = false
			$TextureButton.disabled = true
			$SpicePile.visible = false
		else:
			update_text()
			
			
	else:
		if not already_poor:
			already_poor = true
			$PanelContainer/RichTextLabel.add_text("Oh no lil' sailor, you don't have enough to buy that.")

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
		
