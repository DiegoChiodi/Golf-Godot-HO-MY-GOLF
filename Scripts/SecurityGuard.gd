extends "res://Scripts/Character.gd"

@onready var bod_ball = get_node("../bod_ball")
@onready var player: CharacterBody2D = get_parent().get_node("Player")

#Mouse ---------------
const mouseInt = 0.5
var attackSus = false
#Impulse -------------
var impulse = Vector2.ZERO
@export var impulse_drag : float = 1.0         # quão rápido o impulso se dissipa
var speed_deep = 0.98

var swingingAngle = 0.9
var swinging = swingingAngle

func _ready() -> void:
	super._ready()
	speed = 25

func _process(delta: float) -> void:
	super._process(delta)
	if Input.is_action_pressed("film"):
		position += Vector2(2,2)
	if attackSus && bod_ball.colPlayer: #Se o mouse está em cima o sprite fica vermelho
		ani.modulate.g = lerp(ani.modulate.g, mouseInt, 0.05)
		ani.modulate.b = lerp(ani.modulate.b, mouseInt, 0.05)
	else: #Volta a cor normal
		ani.modulate.g = lerp(ani.modulate.g, 1.0, 0.05)
		ani.modulate.b = lerp(ani.modulate.b, 1.0, 0.05)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	impulse = impulse.move_toward(Vector2.ZERO, impulse_drag * delta)
	print(impulse)
	speed = lerp(speed, 25.0, speed_deep)

func defDirection () -> Vector2:
	var dir = (player.position - position).normalized()
	# soma do impulso (se existir) + direção de perseguição
	var final_dir: Vector2
	if impulse == Vector2.ZERO:
		final_dir = dir
	else:
		final_dir = dir - impulse * 5
	return final_dir

func getAnimation () -> AnimatedSprite2D:
	return $ani_guard

func _on_area_2d_mouse_entered() -> void:
	attackSus = true
	bod_ball.colEnemy = true
	bod_ball.enemyId = self
	
func _on_area_2d_mouse_exited() -> void:
	bod_ball.colEnemy = false
	attackSus = false
