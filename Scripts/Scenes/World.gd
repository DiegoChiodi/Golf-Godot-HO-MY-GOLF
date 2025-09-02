extends BaseScene  # ou Node3D, se for 3D  
class_name CombactScene
#Load files ------------------
@onready var ball: NormalBall = $ball
var guards : Array[Guard] = []
@onready var spawnGuard = $SpawnGuard

#Functions ----------------
func _ready():  
	# Garante que a câmera siga o Player  
	super._ready()
	"""
	guard.setup(player, self)
	$securityGuard2.setup(player, self)
	$securityGuard3.setup(player, self)
	$securityGuard4.setup(player, self)
	"""
	guards = getGuard()
	for guard in guards:
		guard.setup(player,self)
	
	spawnGuard.setup(self)
	ball.setup(player)

#modulate = cor_rgb(255,255,0

func cor_rgb(r: int, g: int, b: int, a: int = 255) -> Color:  
	return Color(r/255.0, g/255.0, b/255.0, a/255.0)

func getGuard () -> Array[Guard]:
	var guardChilds : Array[Guard] = []
	for child in get_children():
		if child is Guard:
			guardChilds.append(child)
	
	return guardChilds
