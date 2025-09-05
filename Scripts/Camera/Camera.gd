extends Camera2D
class_name Camera

#Nodes
var target
#Camera ----------------
var lissing = 10
var posTarget = Vector2.ZERO
var canBallFollow = false
var posComp : Vector2 = Vector2.ZERO
var extPosComp : Vector2 = Vector2.ZERO
# Parâmetros do tremor
var shake_amount = 0.0
var shake_decay = 1.0  # Velocidade com que o tremor diminui
var original_offset = Vector2.ZERO
var zoomCam = Vector2(2.5,2.5)

var debugCamZoom = false
var permitionDebugZoom = false

func _ready():
	original_offset = offset  # Armazena a posição original da câmera
	zoomCam = Vector2(2.5,2.5)

func _process(delta):

	
	if extPosComp != Vector2.ZERO:
		posTarget = extPosComp
	elif target != null:
		posTarget = target.global_position + posComp
	
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
	
	self.zoom = zoomCam
	if Input.is_action_just_pressed("press_c"):
		debugCamZoom = !debugCamZoom
	
	if permitionDebugZoom:
		if debugCamZoom:
			zoomCam = Vector2(2.5,2.5)
		else:
			zoomCam = Vector2(3.5,3.5)

func start_shake(intensity: float, decay: float = 1.0):
	shake_amount = intensity
	shake_decay = decay

func setup(_target, _posComp) -> void:
	setTarget(_target, _posComp)
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

func setLimit(_limit : Vector2) -> void:
	self.limit_left = 0
	self.limit_top = 0
	self.limit_right = _limit.x
	self.limit_bottom = _limit.y

func setTarget(_target, _posComp) -> void:
	self.target = _target
	if _posComp != null:
		posComp = _posComp
	if target is MapHead:
		debugCamZoom = !debugCamZoom
	else:
		debugCamZoom = false

func setExtPosComp(_extPosComp) -> void:
	extPosComp = _extPosComp
