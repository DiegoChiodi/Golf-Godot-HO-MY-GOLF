extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	var areFather = area.get_parent()
	if areFather.is_in_group("ball") and areFather.posZ <= 2 and area.is_in_group("colHb") and areFather.speed > Vector2(2,2): 
		game_manager.finishWorld()
