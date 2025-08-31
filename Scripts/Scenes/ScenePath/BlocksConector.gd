extends Line2D
class_name BlocksConector

var blocks : Array[SceneBlock] = []
@onready var area : Area2D = $Area2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	for areaBlock in area.get_overlapping_areas():
		if areaBlock.get_parent() is SceneBlock and !blocks.has(areaBlock.get_parent()):
			blocks.append(areaBlock.get_parent())
			print("Bloco detectados no início:", areaBlock.get_parent())
