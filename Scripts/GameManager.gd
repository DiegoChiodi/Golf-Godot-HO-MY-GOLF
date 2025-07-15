extends Node

var player : Player = preload("res://Scenes/Player.tscn").instantiate()
var camera : Camera = Camera.new()
var worldContainer : WorldContainer = WorldContainer.new()

func init(main : Node2D):
	self.camera.setup(player)
	main.add_child(camera)
	main.add_child(player)
	self.worldContainer.setup(player, camera)
	main.add_child(worldContainer)
