extends Sprite2D

@export var hand : int
var player : Player

func _ready() -> void:
	z_index = 5 + hand
		
func _process(delta: float) -> void:
	#position = Vector2.DOWN.rotated(golfClub.rotation) * (10 + hand)
	look_at(get_global_mouse_position())
	var dirMouse : Vector2 = (get_global_mouse_position() - self.player.global_position).normalized()
	rotation = dirMouse.angle()
	global_position = player.global_position + Vector2(10,10) * dirMouse

func setup(_player : Player) -> void:
	player = _player
