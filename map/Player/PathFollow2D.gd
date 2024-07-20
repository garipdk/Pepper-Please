extends PathFollow2D
var is_moving:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_moving and progress_ratio < 1.:
		progress_ratio += delta
	elif progress_ratio >= 1.:
		is_moving = false
		var pos = $MapPlayer.global_position
		progress_ratio = 0.
		$MapPlayer.global_position = pos 
		if not PepperGlobal.canChangeScene:
			PepperGlobal.canChangeScene = true
	pass
