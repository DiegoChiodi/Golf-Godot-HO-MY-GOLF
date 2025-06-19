extends "res://Scripts/IntercatArea.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta):
	var space = Input.is_action_just_pressed("move_space")
	
	if colPlayer:
		if space:
			if !get_parent().toRide:
				get_parent().toRide = true
			else:
				get_parent().toRide = false
				get_parent().exit = true
