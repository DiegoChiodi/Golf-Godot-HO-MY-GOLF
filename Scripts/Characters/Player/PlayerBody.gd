extends Movel
class_name Player

var colEnemy : bool = false
var colBall : bool = false
var drivingCart : bool = false
var enemyId = null

@onready var hands : Node2D = $Hands
@onready var actualClub = $ActualClub


func _ready() -> void:
	sliceX = 1
	sliceY = 3
	super._ready()
	
	actualClub.setup(self)
	hands.setup(self)
	
func _process(delta: float) -> void:
	super._process(delta)
	
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if colRival:
		colRivalId.collisionImpulse((global_position - colRivalId.global_position).normalized() * 1)

func setMoveDirection () -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down") - colImpulse
	
func setDirection () -> Vector2:
	#Pega o ponto do player e subtrai ao ponto do mouse, assim pegando o vetor
	return (get_global_mouse_position() - self.global_position).normalized()

func setDraw () -> void:
	drawSelf = $spr_player

func groupsAdd () -> void:
	groupRival = "enemy"
	groupSelf = "player"
