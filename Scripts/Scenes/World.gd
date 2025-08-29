extends BaseScene  # ou Node3D, se for 3D  

#Load files ------------------
@onready var ball: NormalBall = $ball
@onready var shadowBall : ShadowBall = $rec_ballShadow
@onready var guard = $securityGuard

#Functions ----------------
func _ready():  
	# Garante que a câmera siga o Player  
	super._ready()
	guard.setup(player, self)
	$securityGuard2.setup(player, self)
	$securityGuard3.setup(player, self)
	shadowBall.setup(ball)
	ball.setup(player)

#modulate = cor_rgb(255,255,0

func cor_rgb(r: int, g: int, b: int, a: int = 255) -> Color:  
	return Color(r/255.0, g/255.0, b/255.0, a/255.0)
