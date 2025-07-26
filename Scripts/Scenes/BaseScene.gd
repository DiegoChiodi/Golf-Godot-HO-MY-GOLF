extends Node2D
class_name BaseScene

var player: Player
var camera: Camera

func setup(_player: Player, _camera: Camera) -> void:
	player = _player
	camera = _camera

func _ready() -> void:
	pass
	
func playerSpawn() -> Vector2:
	return Vector2.ZERO
