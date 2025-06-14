extends CharacterBody2D

@onready var player := get_node("../Player")  # Ajuste o caminho conforme necessário
var direction := Vector2.ZERO
var rotation_speed = 1

var toRide = false
const speed = 1
func _ready():
	pass
func _physics_process(delta: float) -> void:
	if toRide:
		driving(delta)
		player.position.x = position.x
		player.position.y = position.y
	
	rotation_degrees = fmod(rotation_degrees, 360.0)
		
		
func driving(delta: float) -> void:
	var up_keep = Input.is_action_pressed("move_up")
	var down_keep = Input.is_action_pressed("move_down")
	var left_keep = Input.is_action_pressed("move_left")
	var right_keep = Input.is_action_pressed("move_right")
	
	var throttle = Input.get_axis("move_down", "move_up")
	var steer = Input.get_axis("move_left", "move_right")
	var steer_reverse = steer
	"""
	if right_keep:
		rotation_degrees += 90 * delta
	if left_keep:
		rotation_degrees -= 90 * delta
	var direction = Vector2.RIGHT.rotated(deg_to_rad(rotation_degrees))
	if up_keep:
		position += direction * speed * delta
	if down_keep:
		position -= direction * speed * delta * 0.7
	"""
		
	if throttle == -1:
		steer_reverse = steer * -1
		
	velocity = transform.x * speed * throttle
	position += velocity
	
	rotation += steer_reverse * rotation_speed * delta
	
	
