extends Node2D
var pos:Vector2
@export var place_image_path:Texture
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	if place_image_path != null:
		$MapPlaceMouseControl/PlaceSprite2D.texture = place_image_path
		$MapPlaceMouseControl/PlaceSprite2D.scale = Vector2(1,1)
	pos = $MapPlaceMouseControl/PlaceSprite2D.global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

