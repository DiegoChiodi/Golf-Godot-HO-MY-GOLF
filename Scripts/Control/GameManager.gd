extends Node
class_name GameManager

var player : Player = preload("res://Scenes/Player.tscn").instantiate()
var camera : Camera = Camera.new()
var worldContainer : WorldContainer = WorldContainer.new()

var worldPath : String = "res://Scenes/World.tscn"

func init(main : Node2D):
	self.camera.setup(player)
	camera.limit_left = 0
	camera.limit_top = 0
	main.add_child(camera)
	main.add_child(player)
	self.worldContainer.setup(player, camera)
	worldContainer.load_room(worldPath, player, camera)
	player.position = worldContainer.currentRoom.get_node("PlayerSpawn").position
	main.add_child(worldContainer)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		worldContainer.change_room(worldPath, player, camera)
		player.position = worldContainer.currentRoom.get_node("PlayerSpawn").position
		
func finishWorld() -> void:
	self.worldContainer.change_room(worldPath,player,camera)
