extends BaseScene  # ou Node3D, se for 3D  

#Load files ------------------
@onready var ball: NormalBall = $ball
@onready var shadowBall : ShadowBall = $rec_ballShadow
@onready var guard = $securityGuard
@onready var roomSize = $roomSize.global_position

#Functions ----------------
func _ready():  
	# Garante que a câmera siga o Player  
	camera.position = player.position
	guard.setup(player, self)
	camera.setLimit(roomSize)
	camera.position = $PlayerSpawn.position
	shadowBall.setup(ball)

func _process(delta):  
	#modulate = cor_rgb(255,255,0
	pass

func cor_rgb(r: int, g: int, b: int, a: int = 255) -> Color:  
	return Color(r/255.0, g/255.0, b/255.0, a/255.0)
