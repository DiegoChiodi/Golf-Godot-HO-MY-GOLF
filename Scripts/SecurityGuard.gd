extends "res://Scripts/Enemy.gd"

@onready var bod_ball = get_node("../bod_ball")
@onready var player: CharacterBody2D = get_parent().get_node("Player")

#Mouse ---------------
const mouseInt = 0.5
var mouseCol = false
#Impulse -------------
var impulse = Vector2.ZERO
@export var impulse_drag : float = 1.0 # quão rápido o impulso se dissipa
var speed_deep = 0.98

func _ready() -> void:
	super._ready()
	speed = 25

func _process(delta: float) -> void:
	super._process(delta)
	attackSus()
	

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	impulse = impulse.move_toward(Vector2.ZERO, impulse_drag * delta)
	speed = lerp(speed, 25.0, speed_deep)

func defDirection () -> Vector2:
	var dir = (player.position - position).normalized()
	if life == lifeMax:
		dir = -dir
	# soma do impulso (se existir) + direção de perseguição
	var final_dir: Vector2
	if impulse == Vector2.ZERO:
		final_dir = dir
	else:
		final_dir = dir - impulse * 5
	
	return final_dir

func getDraw () -> AnimatedSprite2D:
	return $spr_guard

func _on_area_2d_mouse_entered() -> void:
	mouseCol = true
	bod_ball.colEnemy = true
	bod_ball.enemyId = self
	
func _on_area_2d_mouse_exited() -> void:
	bod_ball.colEnemy = false
	mouseCol = false
	
func _on_are_hb_attack_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		colPlayer = true
		speed = 50
		impulse = (player.position - position).normalized()
		
func _on_are_hb_attack_area_exited(area: Area2D) -> void:
	colPlayer = false

func attackSus():
	if mouseCol && bod_ball.colPlayer: #Se o mouse está em cima o sprite fica vermelho
		drawSelf.modulate.g = lerp(drawSelf.modulate.g, mouseInt, 0.05)
		drawSelf.modulate.b = lerp(drawSelf.modulate.b, mouseInt, 0.05)
	else: #Volta a cor normal
		drawSelf.modulate.g = lerp(drawSelf.modulate.g, 1.0, 0.05)
		drawSelf.modulate.b = lerp(drawSelf.modulate.b, 1.0, 0.05)
