extends LifeObject
class_name Character

#Moving -----------------
var speed : float = 50.0
var acceleration : float = 0.2  # Fator de suavização
var move_direction = Vector2.ZERO
#Impulse -------------
var colImpulse = Vector2.ZERO
const colImpulseDrag : float = 1 # quão rápido o impulso se dissipa

#Impulsioned ----------
var is_impulsioned : bool = false
var impulsionedCowdow : float = 0.0
var impulsionedDelay : float = 0.1

var colHitBox : CollisionShape2D
var areAttackHitBox : Area2D
var colAttackHitBox : CollisionShape2D

func _ready() -> void:
	super._ready()
	if has_node("are_hbAttack"):
		areAttackHitBox = $are_hbAttack
		colAttackHitBox = $are_hbAttack/col_hb
	if has_node("col_colisor"):
		colHitBox = $col_colisor
	groupsAdd()

func _process(delta: float) -> void:
	colorTile()

func _physics_process(delta):
	super._physics_process(delta)
	if is_impulsioned:
		impulsionedCowdow += delta
		if impulsionedCowdow > impulsionedDelay:
			impulsionedCowdow = 0.0
			is_impulsioned = false
	
	colImpulse = colImpulse.lerp(Vector2.ZERO, 2 * delta)
	
	move_direction = setMoveDirection()
	velocity = velocity.lerp(move_direction * speed, acceleration) * getTileSpeed()
	move_and_slide()
	# Controle de drawSelfmação melhorado

func setMoveDirection () -> Vector2:
	return Vector2.ZERO

func stop():
	pass

func collisionImpulse (impulseForce : Vector2):
	if !is_impulsioned:
		colImpulse += impulseForce
		is_impulsioned = true
	
func groupsAdd () -> void:
	if colHitBox != null:
		colHitBox.add_to_group("colHb")
	if areAttackHitBox != null:
		areAttackHitBox.add_to_group("colHbAttack")
		areAttackHitBox.add_to_group("colHb")

func enableCollision (definition : bool) -> void:
	if colHitBox != null:
		colHitBox.set_deferred("disabled", definition)

func getTileisWater() -> bool:
	var tileMap : TileMapLayer = get_tree().get_first_node_in_group("tileGround")
	
	if !tileMap:
		return false
	
	var cell := tileMap.local_to_map(self.global_position)
	var data : TileData = tileMap.get_cell_tile_data(cell)
	if data:
		var tileType : bool = data.get_custom_data("isWater")
		return tileType
	
	return false

func getTileisSand() -> bool:
	var tileMap : TileMapLayer = get_tree().get_first_node_in_group("tileGround")
	
	if !tileMap:
		return false
	
	var cell := tileMap.local_to_map(self.global_position)
	var data : TileData = tileMap.get_cell_tile_data(cell)
	if data:
		var tileType : bool = data.get_custom_data("isSand")
		return tileType
	
	return false

func getTileSpeed() -> float:
	var tileMap : TileMapLayer = get_tree().get_first_node_in_group("tileGround")
	
	if !tileMap:
		return 1
	
	var cell := tileMap.local_to_map(self.global_position)
	var data : TileData = tileMap.get_cell_tile_data(cell)
	if data:
		var tileType : float = data.get_custom_data("speed")
		return tileType
	
	return 1

func colorTile() -> void:
	if getTileisWater():
		self.modulate.b = 2
	elif getTileisSand():
		self.modulate.r = 2
		self.modulate.g = 2
	else:
		self.modulate.r = 1
		self.modulate.g = 1
		self.modulate.b = 1
