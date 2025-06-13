extends Area2D

var colPlayer = false;

func _process(delta):
	if Input.is_action_just_pressed("move_space") && colPlayer:
		print("Ação direita pressionada")
		get_parent().toRide = true
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		colPlayer = true;

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		colPlayer = false;
		
