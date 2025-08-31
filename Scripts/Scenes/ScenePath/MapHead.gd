extends Node2D
class_name MapHead

var possibilitis : Array[BlockScene] = []
var collidingActual : Area2D
@onready var area : Area2D = $Area2D

var delay : float = 1.0
var wait : float = 0.0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		self.global_position = get_global_mouse_position()
	return
	print('aaaaa')
	if wait > delay:
		setPossibilitis()
		wait = -1000000
	else:
		wait += delta
	
	if Input.is_action_just_pressed("left_click"):
		for block in possibilitis:
			if !block.mouseColission:
				self.position = block.position
				setPossibilitis()
	
	
			#print("Bloco detectados no início: ", areaBlock.get_parent())
func setPossibilitis() -> void:
	possibilitis = []
	for areaBlock in area.get_overlapping_areas():
		if areaBlock.get_parent() is BlockScene:
			collidingActual = areaBlock
		
	var lines : Array[BlocksConector] = []
	if collidingActual != null:
		for areaLine in collidingActual.get_overlapping_areas():
			if areaLine.get_parent() is BlocksConector and !lines.has(areaLine.get_parent()):
				lines.append(areaLine.get_parent())
	
	for line in lines:
		for block in line.blocks:
			if !possibilitis.has(block):
				possibilitis.append(block)
	print(possibilitis)
