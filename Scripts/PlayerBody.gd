extends "res://Scripts/ChaSprite.gd"

var colEnemy : bool = false
var enemyId = null

func _ready() -> void:
	sliceX = 1
	sliceY = 3
	super._ready()
	
func _process(delta: float) -> void:
	super._process(delta)
	if colEnemy:
		enemyId.takeDamage(15, (global_position - enemyId.global_position).normalized())

func setMoveDirection () -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down") - colImpulse
	
func setDirection () -> Vector2:
	#Pega o ponto do player e subtrai ao ponto do mouse, assim pegando o vetor
	return (get_global_mouse_position() - self.global_position).normalized()
func getDraw () -> AnimatedSprite2D:
	return $spr_player

func groupsAdd () -> void:
	groupRival = "enemy"
	groupSelf = "player"
