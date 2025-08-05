extends BaseClub
class_name Pistol

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func onEnemyCollision(enemy) -> void:
	var playerPos = self.player.global_position
	var enemyPos = enemy.global_position

	var media = (playerPos + enemyPos).normalized()
	enemy.takeDamage(self.damage, media * 3)
	enemy.mouFollow = true
