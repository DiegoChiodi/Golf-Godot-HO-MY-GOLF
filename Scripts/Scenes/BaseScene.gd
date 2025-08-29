extends Node2D
class_name BaseScene

var player: Player
var camera: Camera

func setup(_player: Player, _camera: Camera) -> void:
	player = _player
	camera = _camera

func _ready() -> void:
	playerSpawn()
	roomSize()
	
func playerSpawn() -> void:
	if has_node('playerSpawn'):
		player.global_position = $playerSpawn.global_position
		
func roomSize() -> void:
	if has_node('roomSize'):
		camera.setLimit($roomSize.global_position)
