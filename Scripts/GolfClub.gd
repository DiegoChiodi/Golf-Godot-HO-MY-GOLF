extends CharacterBody2D

var mouse_pos = get_local_mouse_position()

func _process(delta: float) -> void:
	print(mouse_pos)
