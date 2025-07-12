extends "res://Scripts/Character.gd"

@onready var frameDim = Vector2.ZERO
var sliceX = 1
var sliceY = 1

func _ready() -> void:
	super._ready()
	frameDim = Vector2(drawSelf.texture.get_size().x / sliceX, drawSelf.texture.get_size().y / sliceY)

func runRight():
	drawSelf.region_rect = Rect2(Vector2(0, 0), frameDim) 
	#O y do vetor vale 0 por causa que é para direita

func runDown():
	drawSelf.region_rect = Rect2(Vector2(0, frameDim.y * 1), frameDim)
	
func runUp():
	drawSelf.region_rect = Rect2(Vector2(0, frameDim.y * 2), frameDim)
