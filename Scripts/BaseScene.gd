extends Node2D
class_name BaseScene

var player: CharacterBody2D
var camera: Camera2D

func setup(_player: CharacterBody2D, _camera: Camera2D) -> void:
	player = _player
	camera = _camera

func _ready() -> void:
	pass
