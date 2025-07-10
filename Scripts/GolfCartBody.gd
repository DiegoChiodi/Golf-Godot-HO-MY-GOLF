extends CharacterBody2D

#Load files
@onready var player := get_node("../Player")
@onready var ani_golf: AnimatedSprite2D = $ani_golf
@onready var lbl_debug: Label = $lbl_debug
@onready var col_debug: ColorRect = $rec_colDebug
#Controles ---------------------------
var direction := Vector2.ZERO
var rotationSpeed = 2.5
var toRide = false
var speed = 0
#Draw
const fatAngle = 360 / 8#45
const compAngle = fatAngle / 2
#
var colPlayer = false
var interact = false
var enterDelay = 0.0
var enterCowdow = 0.2
#Transform
var z = 4
var angle = 0

func _ready() -> void:
	ani_golf.z_index = z
	ani_golf.position = Vector2.ZERO
func _process(delta: float) -> void:
	rotation_degrees = int(rotation_degrees) % 360
	angle = rotation_degrees
	if (0 > angle):
		angle += 360
	ani_golf.rotation = -rotation
	if fatAngle * 7 + compAngle < angle || angle < fatAngle * 0 + compAngle:
		lbl_debug.text = "direita"
		ani_golf.play("right")
	elif compAngle < angle && angle < fatAngle * 1 + compAngle:
		lbl_debug.text = "direitaBaixo"
		ani_golf.play("rightDown")
		ani_golf.flip_h = false
	elif fatAngle + compAngle < angle && angle < fatAngle * 2 + compAngle:
		lbl_debug.text = "baixo"
		ani_golf.play("down")
		ani_golf.flip_h = false
	elif fatAngle * 2 + compAngle < angle && angle < fatAngle * 3 + compAngle:
		lbl_debug.text = "esquerda baixo"
		ani_golf.flip_h = true
		ani_golf.play("rightDown")
	elif fatAngle * 3 + compAngle < angle && angle < fatAngle * 4 + compAngle:
		lbl_debug.text = "esquerda"
		ani_golf.flip_h = true
		ani_golf.play("right")
	elif fatAngle * 4 + compAngle < angle && angle < fatAngle * 5 + compAngle:
		lbl_debug.text = "esquerda cima"
		ani_golf.flip_h = true
		ani_golf.play("rightUp")
	elif fatAngle * 5 + compAngle < angle && angle < fatAngle * 6 + compAngle:
		lbl_debug.text = "cima"
		ani_golf.play("up")
		ani_golf.flip_h = false
	elif fatAngle * 6 + compAngle < angle && angle < fatAngle * 7 + compAngle:
		lbl_debug.text = "direita cima"
		ani_golf.play("rightUp")
		ani_golf.flip_h = false
	lbl_debug.rotation = -rotation
	lbl_debug.position = Vector2(0, 0)
		
func _physics_process(delta: float) -> void:
	if colPlayer:
		var space = Input.is_action_just_pressed("move_space")
		enterDelay += delta
		if space && enterDelay > enterCowdow:
			interact = !interact
			player.visible = false if interact else true
			enterDelay = 0.0
		if interact:
			driving(delta)
			player.position.x = position.x
			player.position.y = position.y
		
func driving(delta: float) -> void:
	var throttle = Input.get_axis("move_down", "move_up")
	var steer = Input.get_axis("move_left", "move_right")
	var steerReverse = steer
	var reverse = 1
	
	if throttle == -1:
		steerReverse = -steer
		reverse = 0.66
		
	speed = transform.x * throttle * reverse
	position += speed
	rotation += steerReverse * rotationSpeed * delta * reverse

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		colPlayer = true

func _on_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("player") && !interact:
		colPlayer = false
