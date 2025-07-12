extends Node2D

@onready var spr_golfClub := $spr_golfClub as Sprite2D
@onready var are_attack := $are_attack as Area2D
@onready var col_attack := are_attack.get_node("col_attack") as CollisionShape2D
@onready var player = get_parent()
@onready var debugText := $Label as Label
@onready var debugRect := $ColorRect as ColorRect
#Angle for impulse
var lastAngle = 0
var timeLastAngle = 0.0

const alaLastAngle = 0.3
var compRotation = 0
#Mouse
var pressioned = false
var timePressed = 0.0
const alaPressed = 0.32
var mouseDis = 0.0
var iniMousePos : Vector2 = Vector2.ZERO
var previousPressed = false
#Attack
@export var damage : float = 10.0 
var attacking = false
const rotationSpeed = 0.98
const suavidade = 0.05
var clubFacePosisition = Vector2(2,4)
var angle = 0.0
var enemy_detect : bool = false
#Z
var z = 5

func _ready() -> void:
	spr_golfClub.z_index = z
	
func _process(delta: float) -> void:
	var press = Input.is_action_just_pressed("left_click")
	var pressed = Input.is_action_pressed("left_click")
	var solt = Input.is_action_just_released("left_click")
	
	var B = col_attack.position
	debugRect.position = B
	
	look_at(get_global_mouse_position())
	rotation_degrees -= 90
	
	if press:
		iniMousePos = get_global_mouse_position() - get_parent().position
		previousPressed = true

	if solt && previousPressed:
		previousPressed = false
		mouseDis = (get_global_mouse_position() - get_parent().position)
		attacking = true
	
	angle = int(rotation_degrees) % 360
	if (0 > angle):
		angle += 360
		
func _on_are_attack_area_entered(area: Area2D) -> void:
	if area.is_in_group("colHb") && area.get_parent().is_in_group("enemy"):
		
		var parArea = area.get_parent()
		
		var A = player.global_position
		var B = col_attack.global_position
		var P = parArea.global_position
		
		var dir_a = (A - P).normalized()
		var dir_b = (B - P).normalized()
		
		var media = ((dir_a + dir_b) * 0.5).normalized()
		parArea.takeDamage(damage, media * 3)
		parArea.mouFollow = true
		#parArea.speed = abs((lastAngle - rotation_degrees)) / 2 + 10
		
func rotationAttack (delta : float):
	if !pressioned:
		pass
	else:
		compRotation += delta * -720 * 1.5
		timePressed += delta
		if timePressed > alaPressed:
			timePressed = 0
			compRotation = 0
			pressioned = false
