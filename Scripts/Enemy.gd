extends "res://Scripts/ChaSprite.gd"

var colPlayer = false
var playerTeam
@onready var player: CharacterBody2D = get_parent().get_node("Player")

func _on_are_hb_attack_area_entered(area: Area2D) -> void:
	if area.is_in_group("colHb") and area.get_parent().is_in_group("player"):
		colPlayer = true
		playerTeam = area.get_parent()
		
func _on_are_hb_attack_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		colPlayer = false
		playerTeam = null

func setDirection () -> Vector2:
	return (player.global_position - global_position).normalized()

func setMoveDirection () -> Vector2:
	# soma do impulso (se existir) + direção de perseguição
	var final_dir: Vector2
	final_dir = direction - colImpulse
	
	return final_dir
