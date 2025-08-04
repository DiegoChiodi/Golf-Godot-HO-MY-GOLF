extends BaseClub
class_name GolfClub

func onEnemyColission(enemy):
	var playerPos = self.player.global_position
	var attackPos = self.col_attack.global_position
	var enemyPos = enemy.global_position
	
	var dirPlayerEnemy = (playerPos - enemyPos).normalized()
	var dirAttackEnemy = (attackPos - enemyPos).normalized()
	
	var media = (dirPlayerEnemy + dirAttackEnemy).normalized()
	enemy.takeDamage(self.damage, media * 3)
	enemy.mouFollow = true
