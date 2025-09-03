extends Enemy
class_name Guard

var ball = null
#Speed
var speedNormal = 35.0
var speed_deep = 0.03
#Life
var lifeParcent = 0
var lifeParcentMax = 2
var lestLifeParcent = lifeParcent
var is_week = false
var damage : float = 15

func _ready() -> void:
	sliceX = 3
	sliceY = 4
	super._ready()
	speed = 25

func _process(delta: float) -> void:
	super._process(delta)
	if life < 0:
		self.queue_free()
	elif life < lifeMax * 0.4:
		lifeParcent = 2
		is_week = true
		speedNormal = 20.0
	elif life < lifeMax * 0.7:
		lifeParcent = 1
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
		colRivalId.collisionImpulse((global_position - colRivalId.global_position).normalized() * 1)
		colRivalId.takeDamage(damage)
		#colImpulse = (colRivalId.global_position - global_position).normalized()

func setDirection () -> Vector2:
	if is_week:
		return -super.setDirection()
	return super.setDirection() 
func setDraw () -> void:
	drawSelf = $spr_guard

func _on_area_2d_mouse_entered() -> void:
	if ball == null:
		return
	mouseCol = true
	ball.colEnemy = true
	ball.enemyId = self

func _on_area_2d_mouse_exited() -> void:
	if ball == null:
		return
	ball.colEnemy = false
	mouseCol = false

func setup(_player : Player, _world : BaseScene) -> void:
	super.setup(_player, _world)
	ball = world.ball

func attackSus():
	if mouseCol && ball.colPlayer: #Se o mouse está em cima o sprite fica vermelho
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
