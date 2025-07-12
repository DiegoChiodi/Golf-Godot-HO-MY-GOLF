extends "res://Scripts/ChaSprite.gd"

var colPlayer = false
var playerTeam
	
func _on_are_hb_attack_area_entered(area: Area2D) -> void:
	if area.is_in_group("colHb") and area.get_parent().is_in_group("player"):
		colPlayer = true
		playerTeam = area.get_parent()
		
func _on_are_hb_attack_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		colPlayer = false
		playerTeam = null
		
