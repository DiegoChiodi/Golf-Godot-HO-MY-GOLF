extends "res://Scripts/Character.gd"

#Sprite
@onready var frameDim = drawSelf.texture.get_size() / 3
var timePassed = 0.0
var swingingSpeed = 5
#Life
var life = 0
var lifeMax = 2
var colPlayer = false

func _process(delta: float) -> void:
	super._process(delta)
	timePassed += delta * swingingSpeed  # Velocidade do balanço
	var angle := sin(timePassed) * 8.0  # Oscila entre -10 e +10 graus
	drawSelf.rotation_degrees = angle
	
""" Obs: O x controla o estado de dano, enquanto
o y controla a direção do personagem """

func runRight():
	drawSelf.region_rect = Rect2(Vector2(0, frameDim.y * life), frameDim) 
	#O y do vetor vale 0 por causa que é para direita

func runDown():
	drawSelf.region_rect = Rect2(Vector2(frameDim.x * 1, frameDim.y * life), frameDim)
	
func runUp():
	drawSelf.region_rect = Rect2(Vector2(frameDim.x * 2, frameDim.y * life), frameDim)

func takeDamage():
	life = life + 1 if life < lifeMax else life
	
func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		colPlayer = true

func _on_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		colPlayer = false
