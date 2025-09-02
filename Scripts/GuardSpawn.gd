extends Node2D

var delay : float = 20
var wait : float = 20
var world : BaseScene
var guard = preload("res://Scenes/SecurityGuard.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if wait > delay:
		delay = randi() % 10 + 15
		wait = 0
		
		var guardIns : Guard = guard.instantiate()
		guardIns.setup(world.player,world)
		guardIns.position = self.position
		world.add_child(guardIns)
	else:
		wait += delta

func setup(_world : BaseScene) -> void:
	world = _world
