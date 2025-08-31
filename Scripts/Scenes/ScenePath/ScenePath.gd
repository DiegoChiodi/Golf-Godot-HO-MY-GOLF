extends BaseScene

var blocks : Array[BlockScene] = []
@onready var mapHead = $MapHead

func _ready() -> void:
	blocks = getBlocks()
	setBlocksFunction()
	camera.setTarget(mapHead)
	camera.setLimit($roomSize.position)

func setBlocksFunction() -> void:
	for block in blocks:
		block.function = randi() % 4 + 1
	

func getBlocks () -> Array[BlockScene]:
	var sceneBlockChilds : Array[BlockScene] = []
	for child in get_children():
		if child is BlockScene:
			sceneBlockChilds.append(child)
	
	return sceneBlockChilds
