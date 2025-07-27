extends Sprite2D

@export var hand : int
var player : Player

func _ready() -> void:
	z_index = 5 + self.hand
		
func _process(delta: float) -> void:
	#position = Vector2.DOWN.rotated(golfClub.rotation) * (10 + self.hand)
	look_at(get_global_mouse_position())
	var dirMouse : Vector2 = (get_global_mouse_position() - self.player.global_position).normalized()
	rotation = dirMouse.angle()
	global_position = player.global_position + Vector2(10,10) * dirMouse + Vector2(self.hand,self.hand)
	
	var clubManager = run_manager.clubManager
	
	if clubManager.actualClub == clubManager.Clubs.HAND:
		pass

func setup(_player : Player) -> void:
	self.player = _player
	
