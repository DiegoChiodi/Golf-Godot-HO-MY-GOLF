extends BaseClub
class_name ClubMelee

@onready var are_attack := $are_attack as Area2D
@onready var col_attack := are_attack.get_node("col_attack") as CollisionShape2D
var inAttacking : bool = false
var enemyStreak : int = 2 #Quantos inimigos posso acertar em um ataque
var displacementAttack := Vector2.ZERO
var finalDisplacemetAttack := Vector2.ZERO
var attacking : bool = false
var attackReturn : bool = false
var attackDurationDelay : float = 1.5
var attackDurationWait : float = 0
var damageTrue : bool = false

func _ready() -> void:
	damage = 20.0

func _process(delta: float) -> void:
	super._process(delta)
	
	if attacking:
		finalDisplacemetAttack = (get_global_mouse_position() - global_position).normalized() * 15
		
		if !attackReturn and (attackDurationWait >= attackDurationDelay or displacementAttack.length()
		 >= (finalDisplacemetAttack.length() * 0.93)):
			attackReturn = true
			attackDurationWait = 0
		else:
			attackDurationWait += delta
		
		if !attackReturn:
			displacementAttack = displacementAttack.lerp(finalDisplacemetAttack, delta * 4) # * Vector2.RIGHT.rotated(rotation)
		else:
			displacementAttack = displacementAttack.lerp(Vector2.ZERO, delta * 3) # * Vector2.RIGHT.rotated(rotation)
		if displacementAttack.length() <= Vector2(1,1).length() and attackReturn:
			attackReturn = false
			attacking = false
			
			
	position = displacementAttack

func attackGo() -> void:
	attacking = true
	
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
	enemy.takeDamage(damage)
	enemy.collisionImpulse(media * 2)
