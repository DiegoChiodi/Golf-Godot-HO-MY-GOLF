extends Sprite2D

@export var hand : int
@onready var golfClub = get_parent().get_node("bod_golfClub")

func _ready() -> void:
	z_index = golfClub.z + hand
	
func _process(delta: float) -> void:
	position = Vector2.DOWN.rotated(golfClub.rotation) * (10 + hand)
