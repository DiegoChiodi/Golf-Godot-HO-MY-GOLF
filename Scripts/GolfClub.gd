extends CharacterBody2D

@onready var spr_golfClub := $spr_golfClub as Sprite2D

var angle
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	rotation_degrees -= 90 
	rotation_degrees = int(rotation_degrees) % 360 
	angle = rotation_degrees
	if (0 > angle):
		angle += 360
	
	"""if angle < 180:
		spr_golfClub.flip_h = true
	else:
		spr_golfClub.flip_h = false
	"""
	print(angle)
