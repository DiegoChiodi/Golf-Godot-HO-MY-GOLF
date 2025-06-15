extends Area2D

var colPlayer = false;
var player

func _process(delta):
	var space = Input.is_action_just_pressed("move_space")
	
	if colPlayer:
		if space:
			if !get_parent().toRide:
				get_parent().toRide = true
			else:
				get_parent().toRide = false
				get_parent().exit = true
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		colPlayer = true;

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		colPlayer = false;
