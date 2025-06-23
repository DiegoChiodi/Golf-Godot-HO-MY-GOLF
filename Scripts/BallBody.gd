extends CharacterBody2D

#Load files ----------------------------
@onready var lblDebug : Label = $lbl_debug
#Scoping ----------------------
var iniMousePos : Vector2
var endMousePos : Vector2
var mouseDis : Vector2
#Colision -------------------
var colPlayer = false
#Fisic ----------------------
var z = 2
var posZ = 0.0
var speed : Vector2
var speedZ
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
	if colPlayer:
		if state == State.IDLE:
			if Input.is_action_just_pressed("left_click"):
				iniMousePos = get_global_mouse_position()
				state = State.SCOPING
		elif state == State.SCOPING:
			if Input.is_action_just_released("left_click"):
				endMousePos = get_global_mouse_position()
				mouseDis = (endMousePos - iniMousePos)
				initialImpulse()
	
	if state == State.MOVING:
		ballMoviment(delta)
			

func _on_area_entered(area: Area2D) -> void:
	colPlayer = true

func _on_area_exited(area: Area2D) -> void:
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
