extends CharacterBody2D

#Moving -----------------
var speed : float = 50.0
var acceleration : float = 0.2  # Fator de suavização
var z : int = 5
var move_direction = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO
#Impulse -------------
var colImpulse = Vector2.ZERO
const colImpulseDrag : float = 1 # quão rápido o impulso se dissipa
#Swing -------------
var timePassed = 0.0
var swingingSpeed : int = 5
var swingingDis : float = 8.0 # < ------------------ Dúvida

#Life system ------------
var lifeMax = 100
var life = lifeMax
var lifeParcent = 0
var lifeParcentMax = 2

# Referência direta ao AnimatedSprite2D (ajuste o nome conforme sua cena)
@onready var drawSelf = getDraw()

func _ready() -> void:
	drawSelf.z_index = z
	
func _process(delta: float) -> void:
	colImpulse = colImpulse.lerp(Vector2.ZERO, 2 * delta)
	if direction.length() > 0.1:  # Threshold para considerar movimento
		drawSelfDir()
	else:
		stop()
		
	if move_direction.length() > 0.1:  # Threshold para considerar movimento
		swing(delta)
	else:
		drawSelf.rotation_degrees = lerp(drawSelf.rotation_degrees, 0.0, 0.05)
		
		
	


func drawSelfDir():
	if abs(direction.x) > abs(direction.y):
		runRight()
		drawSelf.flip_h = direction.x < 0  # Flip apenas no X
	else:
		if direction.y < 0:
			runUp()  # Animação para cima
		else: 
			runDown()

func _physics_process(delta):
	direction = setDirection()
	move_direction = setMoveDirection()
	velocity = velocity.lerp(move_direction * speed, acceleration)
	move_and_slide()
	# Controle de drawSelfmação melhorado

func runRight():
	pass
	
func runUp():
	pass
	
func runDown():
	pass
	
func setMoveDirection () -> Vector2:
	return Vector2.ZERO
	
func setDirection () -> Vector2:
	return Vector2.ZERO
	
func getDraw () -> AnimatedSprite2D:
	return $drawSelf

func stop():
	pass
	
func swing (delta : float):
	timePassed += delta * swingingDis  # Velocidade do balanço
	var angle := sin(timePassed) * swingingDis  # Oscila entre -10 e +10 graus
	drawSelf.rotation_degrees = angle

func takeDamage(damage : float, impulseForce : Vector2):
	life -= damage
	defCollisionImpulse(impulseForce)

func defCollisionImpulse (impulseForce : Vector2):
	colImpulse = impulseForce
