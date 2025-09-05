extends BaseScene  # ou Node3D, se for 3D  
class_name CombactScene
#Load files ------------------
@onready var ball: NormalBall = $ball
var guards : Array[Guard] = []
var spawnGuards: Array[GuardSpawn] = []
#Functions ----------------
func _ready():  
	# Garante que a câmera siga o Player  
	super._ready()
	camera.setTarget(game_manager.player, Vector2.ZERO)
	guards = getGuard()
	for guard in guards:
		guard.setup(player,self)
	
	spawnGuards = getSpanwner()
	for spawnGuard in spawnGuards:
		spawnGuard.setup(self)
	
	ball.setup(player)
	
#modulate = cor_rgb(255,255,0

func _process(delta: float) -> void:
	if ball.state == ball.State.MOVING:
		const targetBallPor = 0.4
		camera.setExtPosComp(player.global_position + ball.mouseDis * targetBallPor)
		camera.lissing = 2.0
		var maxDis = (player.global_position - ball.global_position).length()
		var zoom_alvo = clamp(remap(maxDis, 100, 1000, 1.0, 0.5), 0, 19.0) * 3
		camera.setZoom(camera.zoomTarget.lerp(Vector2(zoom_alvo, zoom_alvo), delta * 2.0))
	else:
		camera.setExtPosComp(Vector2.ZERO)
		camera.lissing += 2 * delta
		camera.lissing = clamp(camera.lissing,0,10)
		const normalZoom = 3.5
		camera.setZoom(camera.zoomTarget.lerp(Vector2(normalZoom,normalZoom), delta))
	
	for guard in guards:
		guard.position = Vector2(100,100)

func cor_rgb(r: int, g: int, b: int, a: int = 255) -> Color:  
	return Color(r/255.0, g/255.0, b/255.0, a/255.0)

func getGuard () -> Array[Guard]:
	var guardChilds : Array[Guard] = []
	for child in get_children():
		if child is Guard:
			guardChilds.append(child)
	
	return guardChilds

func getSpanwner () -> Array[GuardSpawn]:
	var spawnChilds : Array[GuardSpawn] = []
	for child in get_children():
		if child is GuardSpawn:
			spawnChilds.append(child)
	
	return spawnChilds
