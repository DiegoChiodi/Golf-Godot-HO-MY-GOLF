extends Node2D
class_name BaseClub

var player : Player

@onready var spr_golfClub := $spr_golfClub as Sprite2D

#Mouse
var pressioned = false
var previousPressed = false
#Stats
@export var longDamage : float = 0 
var angle = 0.0

func _process(delta: float) -> void:
	var press = Input.is_action_just_pressed("left_click")
	var pressed = Input.is_action_pressed("left_click")
	var solt = Input.is_action_just_released("left_click")
	if press:
		pressMouse()
	
	setAngle()
	
	self.angle = int(self.rotation_degrees) % 360
	if (0 > self.angle):
		self.angle += 360

func pressMouse () -> void:
	self.previousPressed = true

func setAngle() -> void:
	look_at(get_global_mouse_position())

func setup(_player : Player) -> void:
	self.player = _player
