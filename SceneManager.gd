extends Node2D

var current_destination_map:NodePath
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	$Shelves.connect_all_transations($Store)
	$TextureRect.scale = Vector2(0.3, 0.3)
	PepperGlobal.money_changed.connect(_on_money_changed)

func _on_money_changed():
	$Shelves/GoldCounter.text = str(PepperGlobal.money)
	print("loosing condition:", $Port.spices_price[PepperGlobal.number_of_unlocked_spices], PepperGlobal.money,
	 $Store.are_all_bowls_empty)
	if $Port.spices_price[PepperGlobal.number_of_unlocked_spices] > PepperGlobal.money and $Store.are_all_bowls_empty:
		$ColorRectFilnalScreenLoose.visible = true
		
func _input(event:InputEvent):
	if event.is_action_pressed("ui_cancel"):
		$TextureButton.visible = false
		move_child($MapScene, 3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if PepperGlobal.canChangeScene:
		print(current_destination_map.get_name(0))
		#if current_destination_map.get_name(0) == "Store":
		move_child(get_node(current_destination_map), 3)
		PepperGlobal.canChangeScene = false
		$TextureButton.visible = true

func _on_shelves_ready():
	PepperGlobal.shelves = $Shelves


func _on_area_2d_body_entered(_body, extra_arg_0):
	current_destination_map = extra_arg_0


func _on_texture_rect_gui_input(event:InputEvent):
	if event is InputEventMouseButton and event.pressed:
		get_tree().quit()


func _on_texture_button_pressed():
	$TextureButton.visible = false
	move_child($MapScene, 3)


func _on_accept_pressed():
	if PepperGlobal.money >= 100000:
		$ColorRectFilnalScreenWin.visible = true
		pass # WIN !!!
