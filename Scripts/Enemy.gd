extends "res://Scripts/ChaSprite.gd"

@onready var player: CharacterBody2D = get_parent().get_node("Player")

func setDirection () -> Vector2:
	return (player.global_position - global_position).normalized()

func setMoveDirection () -> Vector2:
	# soma do impulso (se existir) + direção de perseguição
	var final_dir: Vector2
	final_dir = direction - colImpulse
	
	return final_dir

func groupsAdd() -> void:
	groupRival = "player"
	groupSelf = "enemy"
