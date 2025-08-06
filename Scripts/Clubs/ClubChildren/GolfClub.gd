extends ClubPhysics
class_name GolfClub

func onEnemyPhysicColission(enemy) -> void:
	super.onEnemyPhysicColission(enemy)
	enemy.mouFollow = true
