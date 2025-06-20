extends ColorRect

@onready var bod_ball = get_parent().get_node("bod_ball")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x = bod_ball.position.x - 2
	position.y = bod_ball.position.y - bod_ball.posZ * delta - 2
