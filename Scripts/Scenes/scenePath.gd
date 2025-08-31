extends BaseScene

var blocks : Array[SceneBlock] = []
@onready var playerHead = $PlayerHead

func _ready() -> void:
	blocks = getBlocks()
	setBlocksFunction()
	camera.setTarget(playerHead)

func setBlocksFunction() -> void:
	for block in blocks:
		block.function = randi() % 4 + 1
	

func getBlocks () -> Array[SceneBlock]:
	var sceneBlockChilds : Array[SceneBlock] = []
	for child in get_children():
		if child is SceneBlock:
			sceneBlockChilds.append(child)
	
	return sceneBlockChilds
