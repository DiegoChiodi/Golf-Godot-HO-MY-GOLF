extends CharacterBody2D

@export var speed : float = 50.0
@export var acceleration : float = 0.2  # Fator de suavização

# Referência direta ao AnimatedSprite2D (ajuste o nome conforme sua cena)
@onready var animation_sprite := $Animation as AnimatedSprite2D

# No script do player (opcional):

func _physics_process(delta):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = velocity.lerp(input_direction * speed, acceleration)
	
	# Controle de animação melhorado
	if input_direction.length() > 0.1:  # Threshold para considerar movimento
		if abs(input_direction.x) > abs(input_direction.y):
			animation_sprite.play("RunX")
			animation_sprite.flip_h = input_direction.x < 0  # Flip apenas no X
		else:
			if input_direction.y < 0:
				animation_sprite.play("RunUp")  # Animação para cima
			else: 
				animation_sprite.play("RunDown")
	else:
		animation_sprite.stop()
		animation_sprite.frame = 0  # Garante o frame de idle
	
	move_and_slide()
