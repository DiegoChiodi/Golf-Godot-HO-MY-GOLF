extends BaseScene  # ou Node3D, se for 3D  

#Load files ------------------
@onready var ball: Node2D = $ball
@onready var guard = $SecurityGuard

#Functions ----------------
func _ready():  
	# Garante que a câmera siga o Player  
	camera.position = player.position
	guard.setup(player, self)

func _process(delta):  
	#modulate = cor_rgb(255,255,0)
	pass
		#get_tree().reload_current_scene()
		
		
func cor_rgb(r: int, g: int, b: int, a: int = 255) -> Color:  
	return Color(r/255.0, g/255.0, b/255.0, a/255.0)
