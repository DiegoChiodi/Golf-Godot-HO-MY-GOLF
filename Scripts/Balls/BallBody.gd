extends Node2D
class_name NormalBall
#Load files ----------------------------
@onready var lblDebug : Label = $lbl_debug
@onready var player : Player = null
#Scoping with Mouse ----------------------
var iniMousePos : Vector2 = Vector2.ZERO
var previousPressed = false
var mouseDis : Vector2
var attack = false
var readyShot = true
const mouDisInterval = 15.0
#Colision -------------------
var colPlayer = false
var colEnemy = false
var enemyId
#Fisic ----------------------
var movSpeed = 1
var z = 2
var posZ = 0.0
var speed : Vector2
var speedZ = 0
const gravity = 9.8
#Objects variants / Life world
var airFriction = 0.99
var groundFriction = 0.95
var golfClubForce = 600.0
#Limits
const disMax = 400
const disMaxZ = 250
const deadZone = 1.0
const forceDeadZone = 8.0
#Stats
enum State {
	IDLE,
	MOVING
}
var state = State.IDLE
#funcition
func _ready() -> void:
	$rec_ball.z_index = z
	
func _process(delta: float) -> void:
	var press = Input.is_action_just_pressed("left_click")
	var solt = Input.is_action_just_released("left_click")
	if colPlayer:
		if readyShot:
			if press:
				iniMousePos = get_global_mouse_position()
				previousPressed = true
			if solt && previousPressed:
				previousPressed = false
				if (get_global_mouse_position() - iniMousePos).length() > mouDisInterval:
					mouseDis = (get_global_mouse_position() - iniMousePos)
					attack = false
					movSpeed = 1
					initialImpulse()
				elif colEnemy:
					mouseDis = (position - enemyId.position)
					attack = true
					position = enemyId.position
					enemyId.takeDamage(0, mouseDis.normalized() * 3)
					movSpeed = 3
					initialImpulse()
	if state == State.MOVING:
		ballMoviment(delta)

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		colPlayer = true
		player = area.get_parent()

func _on_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		colPlayer = false
		player = area.get_parent()

func initialImpulse():
	readyShot = false
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
	#var random = randi_range(0, 2)
	for i in range(movSpeed):
		speed *= frictionFactor
		speedZ += gravity * 15 * delta
		
		position.x += speed.x * delta
		position.y += (speed.y + speedZ) * delta
		posZ += speedZ
		
		if attack && colPlayer:
			speed *= 0.98
			speedZ *= 0.98
		
		if posZ > 0.0:
			speedZ *= -0.6 # Muda a direção e diminui
			posZ = 0.0
			speed.x *= groundFriction
			speed.y *= groundFriction
		
		
		if (abs(speed.x) < forceDeadZone * 3 && abs(speed.y) < forceDeadZone * 3):
			speedZ *= 0.98
			readyShot = true
			
		if abs(speed.x) < deadZone && abs(speed.y) < deadZone && abs(speedZ) < deadZone:
			state = State.IDLE
			speedZ = 0
			posZ = 0
