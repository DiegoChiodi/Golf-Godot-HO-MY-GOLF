extends Obstacle

@export var dirArrow : Vector2

func _ready() -> void:
	var posRect = Vector2.ZERO
	if 0 < dirArrow.x:
		posRect = Vector2(16,0)
	elif 0 > dirArrow.x :
		posRect = Vector2(0,16)
	elif dirArrow.y > 0:
		posRect = Vector2(16,16)
	
	sprite.region_rect = Rect2(posRect, Vector2(16,16))
