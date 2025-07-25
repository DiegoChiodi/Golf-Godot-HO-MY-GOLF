extends TileMap

@onready var ground = $Ground 
@onready var tileSize = ground.tile_set.tile_size
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(str(tileSize))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
