extends "res://Scripts/ChaSprite.gd"

func _ready() -> void:
	sliceX = 1
	sliceY = 3
	super._ready()

func setMoveDirection () -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down") - colImpulse
	
func setDirection () -> Vector2:
	#Pega o ponto do player e subtrai ao ponto do mouse, assim pegando o vetor
	return (get_global_mouse_position() - self.global_position).normalized()
func getDraw () -> AnimatedSprite2D:
	return $spr_player
