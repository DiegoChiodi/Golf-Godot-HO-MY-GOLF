extends "res://Scripts/ChaSprite.gd"

var colPlayer = false
	
func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		colPlayer = true

func _on_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		colPlayer = false
