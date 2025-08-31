extends Node2D
class_name MapHead

var possibilitis : Array[BlockScene] = []
var collidingActual : Area2D
@onready var area : Area2D = $Area2D

var checkWait : float = 0.0
const checkDelay : float = 0.02
var check : bool = true

func _process(delta: float) -> void:
	if checkWait > checkDelay and check:
		setPossibilitis()
		checkWait = 0.0
		check = false
	else:
		checkWait += delta
	if Input.is_action_just_pressed("left_click"):
		for block in possibilitis:
			if block.mouseColission and block.position.y > self.position.y:
				self.position = block.position
				checkWait = 0
				check = true

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
			if !possibilitis.has(block) and self.position.y < block.position.y and block != collidingActual:
				possibilitis.append(block)
