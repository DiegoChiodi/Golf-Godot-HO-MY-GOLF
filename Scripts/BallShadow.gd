extends ColorRect

#Load files
@onready var bod_ball = get_parent().get_node("ball")

func _process(delta: float) -> void:
	#Ball x is equals position ball void 
	position.x = bod_ball.position.x - 2
	position.y = bod_ball.position.y - bod_ball.posZ * delta - 2
