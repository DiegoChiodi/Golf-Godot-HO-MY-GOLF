extends "res://Scripts/ChaSprite.gd"

func _ready() -> void:
	sliceX = 1
	sliceY = 3
	super._ready()

func defDirection () -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down") - colImpulse

func getDraw () -> AnimatedSprite2D:
	return $spr_player
