extends Node2D

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
	500, 1000, 5000, 10000
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
		PepperGlobal.number_of_unlocked_spices += 1
		update_text()
		
