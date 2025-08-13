extends ClubMelee
class_name GolfClub

func _ready() -> void:
	super._ready()
	forceInBall = 800

func onEnemyPhysicColission(enemy) -> void:
	super.onEnemyPhysicColission(enemy)
	enemy.mouFollow = true
