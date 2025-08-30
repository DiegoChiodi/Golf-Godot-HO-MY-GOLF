extends BaseScene

var blocks : Array[SceneBlock] = []


func _ready() -> void:
	blocks = getBlocks()
	setBlocksFunction()

func setBlocksFunction() -> void:
	for block in blocks:
		block.function = randi() % 4 + 1
	

func getBlocks () -> Array[SceneBlock]:
	var sceneBlockChilds : Array[SceneBlock] = []
	for child in get_children():
		if child is SceneBlock:
			sceneBlockChilds.append(child)
	
	return sceneBlockChilds
