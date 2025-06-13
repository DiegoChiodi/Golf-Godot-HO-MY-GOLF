extends CharacterBody2D

@onready var player := get_node("../Player")  # Ajuste o caminho conforme necessário

var toRide = false
const speed = 50
func _ready():
	pass
func _physics_process(delta: float) -> void:
	if toRide:
		driving(delta)
		player.position.x = position.x
		player.position.y = position.y
		
		
func driving(delta: float) -> void:
	var up_keep = Input.is_action_pressed("move_up")
	var down_keep = Input.is_action_pressed("move_down")
	var left_keep = Input.is_action_pressed("move_left")
	var right_keep = Input.is_action_pressed("move_right")

	if right_keep:
		rotation_degrees += 90 * delta
	if left_keep:
		rotation_degrees -= 90 * delta
	if up_keep:
		var direction = Vector2.RIGHT.rotated(deg_to_rad(rotation_degrees))
		position += direction * speed * delta
	if down_keep:
		var direction = Vector2.LEFT.rotated(deg_to_rad(rotation_degrees))
		position -= direction * speed * delta
