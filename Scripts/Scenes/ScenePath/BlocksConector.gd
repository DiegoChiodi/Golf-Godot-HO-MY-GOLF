extends Line2D
class_name BlocksConector

var blocks : Array[BlockScene] = []
@onready var area : Area2D = $Area2D

func _ready() -> void:
	z_index = -1

func _process(delta: float) -> void:
	for areaBlock in area.get_overlapping_areas():
		if areaBlock.get_parent() is BlockScene and !blocks.has(areaBlock.get_parent()):
			blocks.append(areaBlock.get_parent())
			#print("Bloco detectados no início: ", areaBlock.get_parent())
