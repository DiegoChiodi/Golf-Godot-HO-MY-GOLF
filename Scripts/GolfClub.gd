extends CharacterBody2D

@onready var spr_golfClub := $spr_golfClub as Sprite2D
@onready var z = 5

#Angle for impulse
var lastAngle = 0
var timeLastAngle = 0.0

const alaLastAngle = 0.3
var compRotation = 0
#Mouse
var pressioned = false
var timePressed = 0.0
const alaPressed = 0.32



var angle

func _ready() -> void:
	spr_golfClub.z_index = z
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	rotation_degrees += 90
	if !pressioned:
		pass
	else:
		compRotation += delta * -720 * 1.5
		timePressed += delta
		if timePressed > alaPressed:
			timePressed = 0
			compRotation = 0
			pressioned = false
			
	rotation_degrees += compRotation
	
	var clickLeft = Input.is_action_just_pressed("left_click")
	if clickLeft:
		pressioned = true
	timeLastAngle += delta
	if timeLastAngle > alaLastAngle:
		timeLastAngle = 0
		lastAngle = rotation_degrees
	angle = int(rotation_degrees) % 360
	if (0 > angle):
		angle += 360
		
func _on_are_attack_area_entered(area: Area2D) -> void:
	if area.is_in_group("colHb") && area.get_parent().is_in_group("enemy"):
		var parArea = area.get_parent()
		parArea.impulse = (get_parent().position - parArea.position).normalized()
		parArea.speed += 35
		#parArea.speed = abs((lastAngle - rotation_degrees)) / 2 + 10
		print(abs(lastAngle - rotation_degrees))
