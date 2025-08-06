extends BaseClub
class_name ClubPhysics

@export var physicDamage : float = 0

@onready var are_attack := $are_attack as Area2D
@onready var col_attack := are_attack.get_node("col_attack") as CollisionShape2D

func _on_are_attack_area_entered(area: Area2D) -> void:
	if area.is_in_group("colHb") && area.get_parent().is_in_group("enemy"):
		self.onEnemyPhysicColission(area.get_parent())

func onEnemyPhysicColission(enemy) -> void:
	var playerPos = self.player.global_position
	var attackPos = self.col_attack.global_position
	var enemyPos = enemy.global_position
	
	var dirPlayerEnemy = (playerPos - enemyPos).normalized()
	var dirAttackEnemy = (attackPos - enemyPos).normalized()
	
	var media = (dirPlayerEnemy + dirAttackEnemy).normalized()
	enemy.takeDamage(self.physicDamage, media * 3)
