extends BaseClub
class_name Pistol

func onEnemyCollision(enemy) -> void:
	var playerPos = self.player.global_position
	var enemyPos = enemy.global_position

	var media = (playerPos + enemyPos).normalized()
	enemy.takeDamage(self.damage, media * 3)
	enemy.mouFollow = true
