extends Node2D

var rng = RandomNumberGenerator.new()

var bar_width: float
var direction: int = 1
var is_moving: bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	bar_width = $Sprite2D.texture.get_width() * $Sprite2D.scale[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_moving == true:
		$Arrow.position.x += direction*10*delta
		if absf($Arrow.position.x) >= bar_width / 2:
			direction *= -1
			
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		is_moving = false
