extends Node2D  # ou Node3D, se for 3D  

@onready var camera: Camera2D = $Camera
@onready var player: CharacterBody2D = $Player  # Assumindo que o nó do Player se chama "Player"  

var pintGren = false
func _ready():  
	# Garante que a câmera siga o Player  
	camera.position = player.position  

func _process(delta):  
	# Atualiza a posição da câmera para acompanhar o Player (suavizado opcional)  
	camera.position = camera.position.lerp(player.position, delta * 10.0)  # Ajuste o "5.0" para mudar a suavidade  
	#modulate = cor_rgb(255,255,0)
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		
func cor_rgb(r: int, g: int, b: int, a: int = 255) -> Color:  
	return Color(r/255.0, g/255.0, b/255.0, a/255.0)  
