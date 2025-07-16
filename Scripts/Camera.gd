extends Camera2D
class_name Camera

#Nodes
var target
#Camera ----------------
const normalZoom = 3.5
var lissing = 10
var posTarget = Vector2.ZERO
const targetBallPor = 0.4
var canBallFollow = false
# Parâmetros do tremor
var shake_amount = 0.0
var shake_decay = 1.0  # Velocidade com que o tremor diminui
var original_offset = Vector2.ZERO


func _ready():
	original_offset = offset  # Armazena a posição original da câmera
	self.zoom = Vector2(3.5,3.5)

func _process(delta):
	posTarget = target.position
	self.position = self.position.lerp(posTarget, delta * lissing)  # Ajuste o "5.0" para mudar a suavidade
	if shake_amount > 0:
		# Aplica uma posição aleatória
		offset = original_offset + Vector2(
			randf_range(-1, 1),
			randf_range(-1, 1)
		) * shake_amount
		
		# Reduz a intensidade ao longo do tempo
		shake_amount = max(shake_amount - shake_decay * delta, 0)
	else:
		# Restaura a posição original
		offset = original_offset

func start_shake(intensity: float, decay: float = 1.0):
	shake_amount = intensity
	shake_decay = decay

func setup(_target) -> void:
	target = _target
"""
func followBall(delta : float ) -> void:
	if ball.state == ball.State.MOVING && !ball.attack:
		posTarget = player.position + ball.mouseDis * targetBallPor
		lissing = 2.0
		var maxDis = (player.position - ball.position).length()
		var zoom_alvo = clamp(remap(maxDis, 100, 1000, 1.0, 0.5), 0.5, 2.0) * 3.0
		camera.zoom = camera.zoom.lerp(Vector2(zoom_alvo, zoom_alvo), delta * 2.0)
	else:
		lissing += 2 * delta
		lissing = clamp(lissing,0,10) 
		camera.zoom = camera.zoom.lerp(Vector2(normalZoom,normalZoom), delta * 2)"""
