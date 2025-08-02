extends Node2D
class_name WorldContainer

var player: Player
var camera: Camera

func setup(_player: Player, _camera: Camera) -> void:
	player = _player
	camera = _camera

var currentRoom

func destroy_room() -> void:
	currentRoom.queue_free()

func load_room(path : String, player : Player, camera : Camera) -> void:
	currentRoom = load(path).instantiate()
	if currentRoom is BaseScene:
		currentRoom.setup(player, camera)
	add_child(currentRoom)

func change_room(path : String, player : Player, camera : Camera) -> void:
	destroy_room()
	load_room(path, player, camera)
