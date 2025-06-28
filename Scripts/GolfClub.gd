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
		
func _on_are_attack_area_entered(area: Area2D) -> void:
	if area.is_in_group("colHb") && area.get_parent().is_in_group("enemy"):
		var parArea = area.get_parent()
		parArea.impulse = (get_parent().position - parArea.position).normalized()
		parArea.speed += 25
