extends CharacterBody2D

#Load files ----------------------------
@onready var lblDebug : Label = $lbl_debug
#Scoping ----------------------
var iniMousePos : Vector2
var mouseDis : Vector2
var keepMouse = 0
#Colision -------------------
var colPlayer = false
var colEnemy = false
var enemyId
#Fisic ----------------------
var z = 2
var posZ = 0.0
var speed : Vector2
var speedZ = 0
const gravity = 9.8
#Objects variants / Life world
var airFriction = 0.98
var groundFriction = 0.95
var golfClubForce = 400.0
#Limits
const disMax = 400
const disMaxZ = 250
const deadZone = 1.0
const forceDeadZone = 8.0
#Stats
enum State {
	IDLE,
	SCOPING,
	MOVING
}
var state = State.IDLE
#funcition
func _ready() -> void:
	$rec_ball.z_index = z
func _process(delta: float) -> void:
	var press = Input.is_action_just_pressed("left_click")
	var pressed = Input.is_action_pressed("left_click")
	var solt = Input.is_action_just_released("left_click")
	if colPlayer:
		if state == State.IDLE:
			if press:
				iniMousePos = get_global_mouse_position()
			if pressed:
				keepMouse += 1 * delta
			if solt:
				if keepMouse > 0.15:
					mouseDis = (get_global_mouse_position() - iniMousePos)
					initialImpulse()
					keepMouse = 0
				elif colEnemy:
					mouseDis = (position - get_global_mouse_position())
					initialImpulse()
					position = enemyId.position
	if state == State.MOVING:
		ballMoviment(delta)

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		colPlayer = true

func _on_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		colPlayer = false

func initialImpulse():
	var dis = mouseDis.length()
	if dis > disMax:
		dis = disMax
	var dir = mouseDis.normalized()
	var forcaFinal = dis / disMax * golfClubForce
	speed.x = forcaFinal * dir.x
	speed.y = forcaFinal * dir.y
	
	speedZ = forcaFinal * 0.625 if forcaFinal < disMaxZ else disMaxZ
	state = State.MOVING
	
func ballMoviment(delta : float):
	var frictionFactor = exp(-airFriction * delta)
	speed *= frictionFactor
	speedZ += gravity * 15 * delta
	posZ += speedZ
	position.x += speed.x * delta
	position.y += (speed.y + speedZ) * delta
	
	if posZ > 0.0:
		speedZ *= -0.6 # Muda a direção e diminui
		posZ = 0.0
		speed.x *= groundFriction
		speed.y *= groundFriction
	
	if abs(speed.x) < forceDeadZone && abs(speed.y) < forceDeadZone:
		speedZ *= 0.98
			
	if abs(speed.x) < deadZone && abs(speed.y) < deadZone && abs(speedZ) < deadZone:
		state = State.IDLE
		speedZ = 0
		posZ = 0
