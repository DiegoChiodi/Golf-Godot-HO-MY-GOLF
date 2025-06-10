extends Node2D  # ou Node3D, se for 3D  

@onready var camera: Camera2D = $Camera
@onready var player: CharacterBody2D = $Player  # Assumindo que o nó do Player se chama "Player"  


func _ready():  
	# Garante que a câmera siga o Player  
	camera.position = player.position  

func _process(delta):  
	# Atualiza a posição da câmera para acompanhar o Player (suavizado opcional)  
	camera.position = camera.position.lerp(player.position, delta * 10.0)  # Ajuste o "5.0" para mudar a suavidade  
	
