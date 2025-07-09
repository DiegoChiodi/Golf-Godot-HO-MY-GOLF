extends Sprite2D

@export var hand : int
@onready var golfClub = get_parent().get_node("bod_golfClub")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = golfClub.z + hand
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = Vector2.DOWN.rotated(golfClub.rotation) * (10 + hand)
