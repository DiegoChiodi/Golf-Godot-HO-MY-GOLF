extends Node
class_name GameManager

var player : Player = preload("res://Scenes/Player.tscn").instantiate()
var camera : Camera = Camera.new()
var worldContainer : WorldContainer = WorldContainer.new()

var worldPath : String = "res://Scenes/TrainingCamp.tscn"
var scenePath : String = "res://Scenes/ScenePath.tscn"
var actualScenePath : String

func init(main : Node2D):
	self.camera.setup(player, null)
	camera.limit_left = 0
	camera.limit_top = 0
	main.add_child(camera)
	main.add_child(player)
	self.worldContainer.setup(player, camera)
	worldContainer.load_room(worldPath)
	main.add_child(worldContainer)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		worldContainer.restart_room()
	
	if Input.is_action_just_pressed("next"):
		finishWorld()

func setScenePath(_scenePath : String) -> void:
	actualScenePath = _scenePath
	self.worldContainer.change_room(actualScenePath)

func finishWorld() -> void:
	self.worldContainer.change_room(scenePath)
