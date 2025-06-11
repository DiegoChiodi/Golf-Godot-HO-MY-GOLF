extends CharacterBody2D

const player := preload("res://Scripts/PlayerBody.gd")


var entered_body_id : int = -1  # -1 significa "vazio/nada entrou"
func _ready():
	pass
func _physics_process(delta: float) -> void:
	pass    


func _on_intercat_area_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
