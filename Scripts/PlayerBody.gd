extends "res://Scripts/Character.gd"

func defDirection () -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")

func getDraw () -> AnimatedSprite2D:
	return $ani_player
	
func stop():
	drawSelf.stop()
	drawSelf.frame = 0  # Garante o frame de idle
