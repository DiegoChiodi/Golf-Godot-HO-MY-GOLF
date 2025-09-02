extends Character
class_name NormalBall
#Load files ----------------------------
@onready var sprBall : ColorRect = $rec_ball
var player : Player
#Scoping with Mouse ----------------------
var iniMousePos : Vector2 = Vector2.ZERO
var previousPressed = false
var mouseDis : Vector2
var attack : bool = false
var readyShot : bool = true # permissão para a acertar a bolinha
const mouDisInterval : float = 8.0
var line
#Colision -------------------
var colPlayer = false
var colEnemy = false
var enemyId
#Fisic ----------------------
var movSpeed = 1
var posZ = 0.0
var speedZ = 0
const gravity = 9.8
const gravityExcedeed = 25
#Objects variants / Life world
var airFriction = 0.99
var groundFriction = 0.95
var golfClub
#Limits
const disMax = 400
const disMaxZ = 250
const deadZone = 1.0
const forceDeadZone = 8.0
#Stats
enum State {
	IDLE,
	MOVING
}
var state = State.IDLE
var lines : Array[Line2D] = []
#funcition
func _ready() -> void:
	var shadowBall : ShadowBall = ShadowBall.new()
	shadowBall.setup(self)
	get_parent().call_deferred("add_child", shadowBall)

func _process(delta: float) -> void:
	
	var press = Input.is_action_just_pressed("left_click")
	var solt = Input.is_action_just_released("left_click")
	if readyShot: # se posso tacar
		modulate.g = lerp(modulate.g, 1.0, 0.09)
		modulate.b = lerp(modulate.b, 1.0, 0.09)
		if colPlayer:
			golfClub = self.player.actualClub.actualClub
			if press:
				if line != null:
					line.queue_free()
				iniMousePos = get_global_mouse_position()
				previousPressed = true
				line = create_line(get_local_mouse_position())
				add_child(line)
				lines.append(line)
				
			if line != null:
				var mousePos = get_local_mouse_position()
				var points = line.points
				points[1] = mousePos
				line.points = points
				
			if previousPressed:
				if solt:
					line.queue_free()
					var mousePos = get_global_mouse_position()
					previousPressed = false
					
					if (mousePos - iniMousePos).length() > mouDisInterval:
						mouseDis = (mousePos - iniMousePos)
						attack = false
						movSpeed = 1
						initialImpulse()
					elif colEnemy:
						mouseDis = (position - enemyId.position)
						attack = true
						position = enemyId.position
						enemyId.takeDamage(0)
						enemyId.collisionImpulse(mouseDis.normalized() * 3)
						movSpeed = 3
						initialImpulse()
	else:
		modulate.g = lerp(modulate.g, 0.2, 0.09)
		modulate.b = lerp(modulate.b, 0.2, 0.09)
		if line != null:
			line.queue_free()
	
	if !colPlayer and line != null:
		line.queue_free()
	
	if state == State.MOVING:
		ballMoviment(delta)
		
func setup(_player) -> void:
	player = _player

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		self.colPlayer = true
		self.player = area.get_parent()
		self.player.colBall = true

func _on_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		self.colPlayer = false
		self.previousPressed = false
		self.player.colBall = false

func initialImpulse():
	readyShot = false
	var dis = mouseDis.length()
	if dis > disMax:
		dis = disMax
	var dir = mouseDis.normalized()
	var forcaFinal
	if golfClub.shotIsNormal():
		forcaFinal = dis / disMax * golfClub.forceInBall
	else:
		forcaFinal = golfClub.forceInBall
	
	velocity.x = forcaFinal * dir.x
	velocity.y = forcaFinal * dir.y
	
	speedZ = forcaFinal * 0.625 if forcaFinal < disMaxZ else disMaxZ
	state = State.MOVING

func _physics_process(delta: float) -> void:
	pass

func ballMoviment(delta : float):
	var frictionFactor = exp(-airFriction * delta)
	#var random = randi_range(0, 2)
	for i in range(movSpeed):
		velocity *= frictionFactor
		speedZ += gravity * gravityExcedeed * delta
		
		position.x += velocity.x * delta
		position.y += (velocity.y + speedZ) * delta
		posZ += speedZ
		
		if attack && colPlayer:
			velocity *= 0.98
			speedZ *= 0.98
		
		if posZ > 0.0:
			speedZ *= -0.6 # Muda a direção e diminui
			posZ = 0.0
			velocity.x *= groundFriction
			velocity.y *= groundFriction
		
		
		if (abs(velocity.x) < forceDeadZone * 3 && abs(velocity.y) < forceDeadZone * 3):
			speedZ *= 0.98
			readyShot = true
			
		if abs(velocity.x) < deadZone && abs(velocity.y) < deadZone && abs(speedZ) < deadZone * 4:
			state = State.IDLE
			speedZ = 0
			posZ = 0

func create_line(initialPoint : Vector2) -> Line2D:
	var line := Line2D.new()
	
	# Pontos
	line.points = PackedVector2Array([
		initialPoint,
		Vector2(0,0)
	])

	# Largura da linha
	line.width = 5.0
	line.closed = true  # Igual ao "Closed: On" da imagem

	# Curva de largura
	var curve := Curve.new()
	curve.add_point(Vector2(0.0, 0.0))
	curve.add_point(Vector2(1.0, 1.0))
	line.width_curve = curve

	return line

func getSize() -> Vector2:
	return sprBall.size
