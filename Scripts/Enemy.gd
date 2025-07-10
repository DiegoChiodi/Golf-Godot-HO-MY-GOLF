extends "res://Scripts/ChaSprite.gd"

var colPlayer = false

""" Obs: O x controla o estado de dano, enquanto
o y controla a direção do personagem """
func _process(delta: float) -> void:
	super._process(delta)
	if life < lifeMax / 3:
		lifeParcent = 2
	elif life < lifeMax - lifeMax / 3:
		lifeParcent = 1
	
func runRight():
	drawSelf.region_rect = Rect2(Vector2(frameDim.x * lifeParcent, 0), frameDim) 
	#O y do vetor vale 0 por causa que é para direita

func runDown():
	drawSelf.region_rect = Rect2(Vector2(frameDim.x * lifeParcent ,frameDim.y * 1), frameDim)
	
func runUp():
	drawSelf.region_rect = Rect2(Vector2(frameDim.x * lifeParcent,frameDim.y * 2), frameDim)
	
func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		colPlayer = true

func _on_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		colPlayer = false
