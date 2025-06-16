extends CharacterBody2D

@onready var player := get_node("../Player")  # Ajuste o caminho conforme necessário
var direction := Vector2.ZERO
var rotation_speed = 2.5

var toRide = false
const speed = 1
var exit = false

@onready var spr := $spr_golfCart as Sprite2D
@onready var lbl_debug: Label = $lbl_debug

enum State {
	UP,
	DOWN,
	LEFT,
	RIGHT
}
var state = State.RIGHT

@onready var angle = 0

func _process(delta: float) -> void:
	rotation_degrees = int(rotation_degrees) % 360
	angle = rotation_degrees
	if (0 > angle):
		angle += 360
	
	lbl_debug.text = "%.2f" % angle  # Ex.: "90.00" ou "45.50"
	
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
