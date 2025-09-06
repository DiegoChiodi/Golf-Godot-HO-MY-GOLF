extends Node
class_name GameManager

var player : Player = preload("res://Scenes/Player.tscn").instantiate()
var camera : Camera = Camera.new()
var worldContainer : WorldContainer = WorldContainer.new()

#Specific Scenes
var trainigScene : String = "res://Scenes/Scene/TrainingCamp.tscn"
var scenePath : String = "res://Scenes/Scene/ScenePath.tscn"
#Combact Scenes
var lineWorld : String = "res://Scenes/Scene/LineWorld.tscn"
var oasis : String = "res://Scenes/Scene/Oasis.tscn"
var actualScenePath : String

func init(main : Node2D):
	self.camera.setup(player, null)
	camera.limit_left = 0
	camera.limit_top = 0
	main.add_child(camera)
	main.add_child(player)
	self.worldContainer.setup(player, camera)
	worldContainer.load_room(trainigScene)
	main.add_child(worldContainer)
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	DisplayServer.window_set_size(DisplayServer.screen_get_size())
	center_window(DisplayServer.screen_get_size())

func center_window(new_size: Vector2i):
	# define o tamanho da janela
	DisplayServer.window_set_size(new_size)
	# pega o tamanho da tela
	var screen_size = DisplayServer.screen_get_size()
	# calcula posição para centralizar
	var pos = (screen_size - new_size) / 2
	# move a janela
	DisplayServer.window_set_position(pos)


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

func comScene(fun : int) -> void:
	match fun:
		1:
			setScenePath(lineWorld)
		2: 
			setScenePath(oasis)
