extends Sprite2D

@export var hand : int

func _ready() -> void:
	#z_index = golfClub.z + hand
	pass
func _process(delta: float) -> void:
	#position = Vector2.DOWN.rotated(golfClub.rotation) * (10 + hand)
	pass
