extends "res://Scripts/Enemy.gd"

@onready var bod_ball = get_node("../bod_ball")

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
#Life
var lifeParcent = 0
var lifeParcentMax = 2

func _ready() -> void:
	sliceX = 3
	sliceY = 4
	super._ready()
	speed = 25

func _process(delta: float) -> void:
	if life < lifeMax / 3:
		lifeParcent = 2
	elif life < lifeMax - lifeMax / 3:
		lifeParcent = 1
	super._process(delta)
	attackSus()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	mouDir = mouDir.lerp(Vector2.ZERO, 2 * delta)
	speed = lerp(speed, speedNormal, speed_deep) #NOJOOOOOOOOO
	
	if mouFollow:
		mouFollowCow += delta
		mouDir = ((get_global_mouse_position() - player.global_position).normalized()
		+ (global_position - player.global_position).normalized()).normalized()
		if mouFollowCow > mouFollowDel:
			mouFollow = false
			mouFollowCow = 0.0
	
	if colRival:
		colRivalId.takeDamage(15, (global_position - colRivalId.global_position).normalized())
		#colImpulse = (colRivalId.global_position - global_position).normalized()

func setMoveDirection () -> Vector2:
	#Se foi muito atacado corre de medo
	if life < lifeMax / 3:
		direction *= -1
		speedNormal = 20.0
	
	# soma do impulso (se existir) + direção de perseguição
	var final_dir: Vector2
	final_dir = direction - colImpulse + mouDir * 2
	
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
	
#func _on_are_hb_attack_area_entered(area: Area2D) -> void:
#	if area.is_in_group("colHb") && area.get_parent().is_in_group("player"):

#	pass

func attackSus():
	if mouseCol && bod_ball.colPlayer: #Se o mouse está em cima o sprite fica vermelho
		pass
	else: #Volta a cor normal
		pass

func runRight():
	drawSelf.region_rect = Rect2(Vector2(frameDim.x * lifeParcent, 0), frameDim) 
	#O y do vetor vale 0 por causa que é para direita

func runDown():
	drawSelf.region_rect = Rect2(Vector2(frameDim.x * lifeParcent, frameDim.y * 1), frameDim)
	
func runUp():
	drawSelf.region_rect = Rect2(Vector2(frameDim.x * lifeParcent, frameDim.y * 2), frameDim)
