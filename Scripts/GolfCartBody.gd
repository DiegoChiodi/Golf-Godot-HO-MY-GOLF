extends CharacterBody2D

@onready var player := get_node("../Player")  # Ajuste o caminho conforme necessário
var direction := Vector2.ZERO
var rotation_speed = 2

var toRide = false
const speed = 1
var exit = false

@onready var ani := $Animation as AnimatedSprite2D

@onready var line = Line2D.new()
var points = []
var width = 4

func _ready() -> void:
	points.clear()
	add_child(line)
	
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
