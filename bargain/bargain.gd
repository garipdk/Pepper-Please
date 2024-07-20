extends Node2D

var rng = RandomNumberGenerator.new()

var bar_width: float

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	bar_width = $Sprite2D.texture.get_width()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
