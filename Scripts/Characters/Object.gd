extends CharacterBody2D
class_name LifeObject

#Life system ------------
var lifeMax = 100
var life = lifeMax

#Damage ----------
var is_invulnerability : bool = false
var invulnerabilityCowdow : float = 0.0
var invulnerabilityDelay : float = 0.4

var drawSelf
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_invulnerability:
		feedbackDamage(0.25)
		invulnerabilityCowdow += delta
		if invulnerabilityCowdow > invulnerabilityDelay:
			invulnerabilityCowdow = 0.0
			is_invulnerability = false
	else:
		feedbackDamage(1.0)

func takeDamage(damage : float):
	if !is_invulnerability:
		life -= damage
		is_invulnerability = true
		invulnerabilityCowdow = 0.0

func feedbackDamage(target : float) -> void:
	drawSelf.modulate.g = lerp(drawSelf.modulate.g, target, 0.09)
	drawSelf.modulate.b = lerp(drawSelf.modulate.b, target, 0.09)
