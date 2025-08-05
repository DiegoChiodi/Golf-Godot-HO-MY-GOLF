extends Node2D
class_name BaseClub

var player : Player

@onready var spr_golfClub := $spr_golfClub as Sprite2D
@onready var are_attack := $are_attack as Area2D
@onready var col_attack := are_attack.get_node("col_attack") as CollisionShape2D

#Mouse
var pressioned = false
var previousPressed = false
#Attack
@export var damage : float = 10.0 
var angle = 0.0
#Z
var z = 5

func _ready() -> void:
	spr_golfClub.z_index = z
	
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

func _on_are_attack_area_entered(area: Area2D) -> void:
	if area.is_in_group("colHb") && area.get_parent().is_in_group("enemy"):
		self.onEnemyColission(area.get_parent())

func onEnemyColission(enemy):
	pass

func setAngle() -> void:
	look_at(get_global_mouse_position())
	self.rotation_degrees -= 90

func setup(_player : Player) -> void:
	self.player = _player
