extends Movel
class_name Enemy

@onready var player: CharacterBody2D = get_parent().get_node("Player")

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
	return (player.global_position - global_position).normalized()

func setMoveDirection () -> Vector2:
	# soma do impulso (se existir) + direção de perseguição
	var final_dir: Vector2
	final_dir = direction - colImpulse + mouDir * 2
	
	return final_dir

func groupsAdd() -> void:
	groupRival = "player"
	groupSelf = "enemy"
