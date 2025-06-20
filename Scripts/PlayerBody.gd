extends Character

@export var speed : float = 50.0
@export var acceleration : float = 0.2  # Fator de suavização
@onready var z = 5

# Referência direta ao AnimatedSprite2D (ajuste o nome conforme sua cena)
@onready var ani_player := $ani_player as AnimatedSprite2D

# No script do player (opcional):
func _ready() -> void:
	ani_player.z_index = z
func _physics_process(delta):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = velocity.lerp(input_direction * speed, acceleration)
	
	# Controle de animação melhorado
	if input_direction.length() > 0.1:  # Threshold para considerar movimento
		if abs(input_direction.x) > abs(input_direction.y):
			ani_player.play("RunX")
			ani_player.flip_h = input_direction.x < 0  # Flip apenas no X
		else:
			if input_direction.y < 0:
				ani_player.play("RunUp")  # Animação para cima
			else: 
				ani_player.play("RunDown")
	else:
		ani_player.stop()
		ani_player.frame = 0  # Garante o frame de idle
	move_and_slide()
