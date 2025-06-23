extends "res://Scripts/Character.gd"

@onready var bod_ball = get_node("../bod_ball")

func _ready() -> void:
	super._ready()
	speed = 25

@onready var player: CharacterBody2D = get_parent().get_node("Player")
func defDirection () -> Vector2:
	return (player.position - position).normalized()

func getAnimation () -> AnimatedSprite2D:
	return $ani_guard

func _on_area_2d_mouse_entered() -> void:
	bod_ball.colEnemy = true
	bod_ball.enemyId = self
