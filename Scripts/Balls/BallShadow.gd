extends ColorRect
class_name ShadowBall
#Load files
var ball

func _process(delta: float) -> void:
	#Ball x is equals position ball void 
	position.x = ball.position.x - 2
	position.y = ball.position.y - ball.posZ * delta - 2
	
	self.color.a = ball.posZ / ball.disMaxZ / - 25


func setup(_ball : NormalBall) -> void:
	ball = _ball
