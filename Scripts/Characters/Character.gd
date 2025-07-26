extends CharacterBody2D
class_name Character

#Moving -----------------
var speed : float = 50.0
var acceleration : float = 0.2  # Fator de suavização
var z : int = 5
var move_direction = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO
#Impulse -------------
var colImpulse = Vector2.ZERO
const colImpulseDrag : float = 1 # quão rápido o impulso se dissipa
#Swing -------------
var timePassed = 0.0
var swingingSpeed : int = 5
var swingingDis : float = 8.0
#Groups -----------
var groupRival : String
var groupSelf : String

#Collision -----------
var colRival
var colRivalId

#Life system ------------
var lifeMax = 100
var life = lifeMax

#Damage ----------
var is_invulnerability : bool = false
var invulnerabilityCowdow : float = 0.0
var invulnerabilityDelay : float = 0.4

# Referência direta ao AnimatedSprite2D (ajuste o nome conforme sua cena)
var drawSelf

func _ready() -> void:
	setDraw()
	drawSelf.z_index = z
	groupsAdd()
	add_to_group(groupSelf)
	
func _process(delta: float) -> void:
	if is_invulnerability:
		feedbackDamage(0.25)
		invulnerabilityCowdow += delta
		if invulnerabilityCowdow > invulnerabilityDelay:
			invulnerabilityCowdow = 0.0
			is_invulnerability = false
	else:
		feedbackDamage(1.0)
	

func _physics_process(delta):
	colImpulse = colImpulse.lerp(Vector2.ZERO, 2 * delta)
	
	move_direction = setMoveDirection()
	velocity = velocity.lerp(move_direction * speed, acceleration)
	move_and_slide()
	# Controle de drawSelfmação melhorado
	
func _on_are_hb_attack_area_entered(area: Area2D) -> void:
	pass

func _on_are_hb_attack_area_exited(area: Area2D) -> void:
	pass

func setMoveDirection () -> Vector2:
	return Vector2.ZERO
	
func setDirection () -> Vector2:
	return Vector2.ZERO
	
func setDraw () -> void:
	drawSelf = null

func stop():
	pass
	
func swing (delta : float):
	timePassed += delta * swingingDis  # Velocidade do balanço
	var angle := sin(timePassed) * swingingDis  # Oscila entre -10 e +10 graus
	drawSelf.rotation_degrees = angle

func takeDamage(damage : float, impulseForce : Vector2):
	if !is_invulnerability:
		life -= damage
		setCollisionImpulse(impulseForce)
		is_invulnerability = true
		invulnerabilityCowdow = 0.0

func feedbackDamage(target : float) -> void:
	drawSelf.modulate.g = lerp(drawSelf.modulate.g, target, 0.09)
	drawSelf.modulate.b = lerp(drawSelf.modulate.b, target, 0.09)

func setCollisionImpulse (impulseForce : Vector2):
	colImpulse = impulseForce
	
func groupsAdd () -> void:
	pass
