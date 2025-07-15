extends BaseScene  # ou Node3D, se for 3D  

#Load files ------------------
@onready var ball: Node2D = $bod_ball

#Functions ----------------
func _ready():  
	# Garante que a câmera siga o Player  
	camera.position = player.position

func _process(delta):  
	#modulate = cor_rgb(255,255,0)
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	# Calcular distância máxima entre os alvos
		
func cor_rgb(r: int, g: int, b: int, a: int = 255) -> Color:  
	return Color(r/255.0, g/255.0, b/255.0, a/255.0)
