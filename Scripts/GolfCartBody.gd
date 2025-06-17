extends CharacterBody2D

@onready var player := get_node("../Player")  # Ajuste o caminho conforme necessário
var direction := Vector2.ZERO
var rotation_speed = 2.5

var toRide = false
const speed = 1
var exit = false
@onready var ani_golf: AnimatedSprite2D = $ani_golf
@onready var lbl_debug: Label = $lbl_debug
var fatAngle = 360 / 8	#45
var compAngle = fatAngle / 2

var angle = 0

func _process(delta: float) -> void:
	rotation_degrees = int(rotation_degrees) % 360
	angle = rotation_degrees
	if (0 > angle):
		angle += 360
	ani_golf.rotation = -rotation
	ani_golf.position = Vector2.ZERO
	ani_golf.flip_h = false
	if fatAngle * 7 + compAngle < angle || angle < fatAngle * 0 + compAngle:
		lbl_debug.text = "direita"
		ani_golf.play("right")
	elif compAngle < angle && angle < fatAngle * 1 + compAngle:
		lbl_debug.text = "direitaBaixo"
		ani_golf.play("rightDown")
	elif fatAngle + compAngle < angle && angle < fatAngle * 2 + compAngle:
		lbl_debug.text = "baixo"
		ani_golf.play("down")
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
	elif fatAngle * 6 + compAngle < angle && angle < fatAngle * 7 + compAngle:
		lbl_debug.text = "direita cima"
		ani_golf.play("rightUp")
	lbl_debug.rotation = -rotation
	lbl_debug.position = Vector2(0, 0)
		
	
func _physics_process(delta: float) -> void:
	if toRide:
		driving(delta)
		player.position.x = position.x
		player.position.y = position.y
		player.visible = false
		
	else:
		if exit:
			player.visible = true
			exit = false
		
		
func driving(delta: float) -> void:
	var throttle = Input.get_axis("move_down", "move_up")
	var steer = Input.get_axis("move_left", "move_right")
	var steer_reverse = steer
		
	if throttle == -1:
		steer_reverse = steer * -1
		
	velocity = transform.x * speed * throttle
	position += velocity
	
	rotation += steer_reverse * rotation_speed * delta
