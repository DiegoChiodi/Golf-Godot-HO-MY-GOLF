extends "res://Scripts/Character.gd"

func _ready() -> void:
	super._ready()
	speed = 25

@onready var player: CharacterBody2D = get_parent().get_node("Player")
func defDirection () -> Vector2:
	return (player.position - position).normalized()

func getAnimation () -> AnimatedSprite2D:
	return $ani_guard
