extends Node2D  # ou Node3D, se for 3D  

#Load files ------------------
@onready var camera: Camera2D = $Camera
@onready var player: CharacterBody2D = $Player  # Assumindo que o nó do Player se chama "Player"  
@onready var ball: CharacterBody2D = $bod_ball
#Camera ----------------
const normalZoom = 3.5
var lissing = 10
var posTarget = Vector2.ZERO
#Functions ----------------
func _ready():  
	# Garante que a câmera siga o Player  
	camera.position = player.position  

func _process(delta):  
	posTarget = player.position # Atualiza a posição da câmera para acompanhar o Player (suavizado opcional) 
	
	#Stages -------------
	#if moving diminui o zoom para ver ball e player
	if ball.state == ball.State.MOVING:
		posTarget = player.position + ball.mouseDis * 0.5
		lissing = 2.0
		var maxDis = (player.position - ball.position).length()
		var zoom_alvo = clamp(remap(maxDis, 100, 1000, 1.0, 0.5), 0.5, 2.0) * 3.0
		camera.zoom = camera.zoom.lerp(Vector2(zoom_alvo, zoom_alvo), delta * 2.0)
	else:
		lissing += 2 * delta
		lissing = clamp(lissing,0,10) 
		camera.zoom = camera.zoom.lerp(Vector2(normalZoom,normalZoom), delta * 2)
	camera.position = camera.position.lerp(posTarget, delta * lissing)  # Ajuste o "5.0" para mudar a suavidade 
	#modulate = cor_rgb(255,255,0)
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		
	# Calcular distância máxima entre os alvos
	
func cor_rgb(r: int, g: int, b: int, a: int = 255) -> Color:  
	return Color(r/255.0, g/255.0, b/255.0, a/255.0)
