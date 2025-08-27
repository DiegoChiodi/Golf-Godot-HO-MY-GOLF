extends CharacterBody2D
class_name Character

#Moving -----------------
var speed : float = 50.0
var acceleration : float = 0.2  # Fator de suavização
var z : int = 5
var move_direction = Vector2.ZERO
#Impulse -------------
var colImpulse = Vector2.ZERO
const colImpulseDrag : float = 1 # quão rápido o impulso se dissipa

#Life system ------------
var lifeMax = 100
var life = lifeMax

#Damage ----------
var is_invulnerability : bool = false
var invulnerabilityCowdow : float = 0.0
var invulnerabilityDelay : float = 0.4
var is_impulsioned : bool = false
var impulsionedCowdow : float = 0.0
var impulsionedDelay : float = 0.2


var drawSelf
@onready var colHitBox : CollisionShape2D = $col_colisor
@onready var areAttackHitBox : Area2D = $are_hbAttack
@onready var colAttackHitBox : CollisionShape2D = $are_hbAttack/col_hb

func _ready() -> void:
	groupsAdd()
	
func _process(delta: float) -> void:
	if is_invulnerability:
		feedbackDamage(0.25)
		invulnerabilityCowdow += delta
		if invulnerabilityCowdow > invulnerabilityDelay:
			invulnerabilityCowdow = 0.0
			is_invulnerability = false
	else:
		feedbackDamage(1.0)
	
	if is_impulsioned:
		impulsionedCowdow += delta
		if impulsionedCowdow > impulsionedDelay:
			impulsionedCowdow = 0.0
			is_impulsioned = false

func _physics_process(delta):
	colImpulse = colImpulse.lerp(Vector2.ZERO, 2 * delta)
	
	move_direction = setMoveDirection()
	velocity = velocity.lerp(move_direction * speed, acceleration)
	move_and_slide()
	# Controle de drawSelfmação melhorado

func setMoveDirection () -> Vector2:
	return Vector2.ZERO

func stop():
	pass

func takeDamage(damage : float):
	if !is_invulnerability:
		life -= damage
		is_invulnerability = true
		invulnerabilityCowdow = 0.0

func feedbackDamage(target : float) -> void:
	drawSelf.modulate.g = lerp(drawSelf.modulate.g, target, 0.09)
	drawSelf.modulate.b = lerp(drawSelf.modulate.b, target, 0.09)

func collisionImpulse (impulseForce : Vector2):
	if !is_impulsioned:
		colImpulse += impulseForce
		is_impulsioned = true
	
func groupsAdd () -> void:
	colHitBox.add_to_group("colHb")
	areAttackHitBox.add_to_group("colHbAttack")
	areAttackHitBox.add_to_group("colHb")

func enableCollision (definition : bool) -> void:
	colHitBox.set_deferred("disabled", definition)
