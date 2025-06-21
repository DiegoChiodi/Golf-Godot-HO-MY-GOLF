extends "res://Scripts/Character.gd"

func defDirection () -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")

func getAnimation () -> AnimatedSprite2D:
	return $ani_player
