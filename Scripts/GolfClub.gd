extends CharacterBody2D

@onready var spr_golfClub := $spr_golfClub as Sprite2D
@onready var z = 5

var angle

func _ready() -> void:
	spr_golfClub.z_index = z
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
