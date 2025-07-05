extends "res://Scripts/ChaSprite.gd"

#Life
var life = 0
var lifeMax = 2
var colPlayer = false
	
""" Obs: O x controla o estado de dano, enquanto
o y controla a direção do personagem """

func runRight():
	drawSelf.region_rect = Rect2(Vector2(frameDim.x * life, 0), frameDim) 
	#O y do vetor vale 0 por causa que é para direita

func runDown():
	drawSelf.region_rect = Rect2(Vector2(frameDim.x * life ,frameDim.y * 1), frameDim)
	
func runUp():
	drawSelf.region_rect = Rect2(Vector2(frameDim.x * life,frameDim.y * 2), frameDim)

func takeDamage():
	life = life + 1 if life < lifeMax else life
	
func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		colPlayer = true

func _on_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		colPlayer = false
