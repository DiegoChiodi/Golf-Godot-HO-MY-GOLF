extends Node2D  # ou Node3D, se for 3D  

@onready var camera: Camera2D = $Camera
@onready var player: CharacterBody2D = $Player  # Assumindo que o nó do Player se chama "Player"  
@onready var ball: CharacterBody2D = $bod_ball
var lissing = 10

var posTarget = Vector2.ZERO

var pintGren = false
func _ready():  
	# Garante que a câmera siga o Player  
	camera.position = player.position  

func _process(delta):  
	# Atualiza a posição da câmera para acompanhar o Player (suavizado opcional) 
	posTarget = player.position
	
	if ball.state == ball.State.MOVING:
		posTarget = player.position + ball.mouseDis / 3
		print(posTarget)
		lissing = 2.0
	else:
		lissing = 10
	
	camera.position = camera.position.lerp(posTarget, delta * lissing)  # Ajuste o "5.0" para mudar a suavidade  
	
	
	#modulate = cor_rgb(255,255,0)
	
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		
		
		
func cor_rgb(r: int, g: int, b: int, a: int = 255) -> Color:  
	return Color(r/255.0, g/255.0, b/255.0, a/255.0)  
