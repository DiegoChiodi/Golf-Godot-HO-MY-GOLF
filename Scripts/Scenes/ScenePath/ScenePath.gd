extends BaseScene

var blocks : Array[BlockScene] = []
@onready var mapHead = $MapHead

func _ready() -> void:
	blocks = getBlocks()
	setBlocksFunction()
	camera.setTarget(mapHead, Vector2(0,100))
	camera.setLimit($roomSize.position)

func setBlocksFunction() -> void:
	for block in blocks:
		
		var sort = randi() % 20
		if sort <= 12:
			block.function = 1
		elif sort <= 15:
			block.function = 2
		elif sort <= 18:
			block.function = 3
		else:
			block.function = 4
		block.setFunction()

func getBlocks () -> Array[BlockScene]:
	var sceneBlockChilds : Array[BlockScene] = []
	for child in get_children():
		if child is BlockScene:
			sceneBlockChilds.append(child)
	
	return sceneBlockChilds
