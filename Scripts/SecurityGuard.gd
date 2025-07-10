extends "res://Scripts/Enemy.gd"

@onready var bod_ball = get_node("../bod_ball")
@onready var player: CharacterBody2D = get_parent().get_node("Player")

#Mouse ---------------
const mouseInt = 0.5
var mouseCol = false
#with attack -
var mouFollow = false
var mouFollowCow = 0.0
var mouFollowDel = 0.3
var mouDir = Vector2.ZERO
const mouDirDrag : float = 1 # quão rápido o impulso do mouse se dissipa
#Speed
var speedNormal = 35.0
var speed_deep = 0.03

func _ready() -> void:
	sliceX = 3
	sliceY = 4
	super._ready()
	speed = 25

func _process(delta: float) -> void:
	super._process(delta)
	attackSus()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	colImpulse = colImpulse.lerp(Vector2.ZERO, 2 * delta)
	mouDir = mouDir.lerp(Vector2.ZERO, 2 * delta)
	speed = lerp(speed, speedNormal, speed_deep)
	
	if mouFollow:
		mouFollowCow += delta
		mouDir = (get_global_mouse_position() - player.position).normalized()
		if mouFollowCow > mouFollowDel:
			mouFollow = false
			mouFollowCow = 0.0

func defDirection () -> Vector2:
	var dir = (player.position - position).normalized()
	#Se foi muito atacado corre de medo
	if life < lifeMax/3:
		dir = -dir
		speedNormal = 20.0
	
	# soma do impulso (se existir) + direção de perseguição
	var final_dir: Vector2
	final_dir = dir - colImpulse + mouDir * 2
	
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
	if area.is_in_group("colHb") && area.get_parent().is_in_group("player"):
		colPlayer = true
		speed = 50
		colImpulse = (player.global_position - global_position).normalized()
		
func _on_are_hb_attack_area_exited(area: Area2D) -> void:
	colPlayer = false

func attackSus():
	if mouseCol && bod_ball.colPlayer: #Se o mouse está em cima o sprite fica vermelho
		drawSelf.modulate.g = lerp(drawSelf.modulate.g, mouseInt, 0.05)
		drawSelf.modulate.b = lerp(drawSelf.modulate.b, mouseInt, 0.05)
	else: #Volta a cor normal
		drawSelf.modulate.g = lerp(drawSelf.modulate.g, 1.0, 0.05)
		drawSelf.modulate.b = lerp(drawSelf.modulate.b, 1.0, 0.05)
