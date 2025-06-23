extends CharacterBody2D

var speed : float = 50.0
var acceleration : float = 0.2  # Fator de suavização
var z = 5
var move_direction = Vector2.ZERO

# Referência direta ao AnimatedSprite2D (ajuste o nome conforme sua cena)
@onready var ani = getAnimation()

# No script do player (opcional):
func _ready() -> void:
	ani.z_index = z
	
func _process(delta: float) -> void:
	if move_direction.length() > 0.1:  # Threshold para considerar movimento
		if abs(move_direction.x) > abs(move_direction.y):
			ani.play("RunRight")
			ani.flip_h = move_direction.x < 0  # Flip apenas no X
		else:
			if move_direction.y < 0:
				ani.play("RunUp")  # Animação para cima
			else: 
				ani.play("RunDown")
	else:
		ani.stop()
		ani.frame = 0  # Garante o frame de idle

func _physics_process(delta):
	move_and_slide()
	move_direction = defDirection()
	velocity = velocity.lerp(move_direction * speed, acceleration)
	# Controle de animação melhorado

func defDirection () -> Vector2:
	return Vector2.ZERO
	
func getAnimation () -> AnimatedSprite2D:
	return $ani
