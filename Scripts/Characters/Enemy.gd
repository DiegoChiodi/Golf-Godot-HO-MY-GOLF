extends Movel
class_name Enemy

var world : BaseScene = null
var player : Player = null
var target : Character = null

#Mouse ---------------
const mouseInt = 0.5
var mouseCol = false
#with attack -
var mouFollow = false
var mouFollowCow = 0.0
var mouFollowDel = 0.3
var mouDir = Vector2.ZERO
const mouDirDrag : float = 1 # quão rápido o impulso do mouse se dissipa

func setDirection () -> Vector2:
	target = selectRival()
	if target == null:
		return Vector2.ZERO
	
	return (target.global_position - global_position).normalized()

func setMoveDirection () -> Vector2:
	# soma do impulso (se existir) + direção de perseguição
	var final_dir: Vector2
	final_dir = direction - colImpulse + mouDir * 2
	
	return final_dir

func groupsAdd() -> void:
	groupRival = "player"
	groupSelf = "enemy"
	
func setup(_player : Player, _world : BaseScene) -> void:
	self.player = _player
	self.world = _world

func selectRival() -> Character:
	#var targets = world.get_nodes_in_group(groupRival)
	return player
