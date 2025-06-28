extends CharacterBody2D

var speed : float = 50.0
var acceleration : float = 0.2  # Fator de suavização
var z = 5
var move_direction = Vector2.ZERO

# Referência direta ao AnimatedSprite2D (ajuste o nome conforme sua cena)
@onready var drawSelf = getDraw()

# No script do player (opcional):
func _ready() -> void:
	drawSelf.z_index = z
	
func _process(delta: float) -> void:
	if move_direction.length() > 0.1:  # Threshold para considerar movimento
		if abs(move_direction.x) > abs(move_direction.y):
			runRight()
			drawSelf.flip_h = move_direction.x < 0  # Flip apenas no X
		else:
			if move_direction.y < 0:
				runUp()  # Animação para cima
			else: 
				runDown()
	else:
		stop()
func runRight():
	drawSelf.play("RunRight")
	
func runUp():
	drawSelf.play("RunUp")
	
func runDown():
	drawSelf.play("RunDown")
func _physics_process(delta):
	move_direction = defDirection()
	velocity = velocity.lerp(move_direction * speed, acceleration)
	move_and_slide()
	# Controle de drawSelfmação melhorado

func defDirection () -> Vector2:
	return Vector2.ZERO
	
func getDraw () -> AnimatedSprite2D:
	return $drawSelf

func stop():
	pass
