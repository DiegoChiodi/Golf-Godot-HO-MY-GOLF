extends BaseScene  # ou Node3D, se for 3D  
class_name CombactScene
#Load files ------------------
@onready var ball: NormalBall = $ball
@onready var hole : Hole = $Hole
@onready var flag : Obstacle = hole.get_node("Flag")
var guards : Array[Guard] = []
var spawnGuards: Array[GuardSpawn] = []
var cutScene : bool = true
@export var lissingMap : float
@onready var cart : GolfCart = $CartBody

#Functions ----------------
func _ready():  
	# Garante que a câmera siga o Player  
	super._ready()
	camera.setExtPosComp(Vector2.ZERO)
	camera.setTarget(game_manager.player, Vector2.ZERO)
	guards = getGuard()
	for guard in guards:
		guard.setup(player,self)
	
	spawnGuards = getSpanwner()
	for spawnGuard in spawnGuards:
		spawnGuard.setup(self)
	camera.setZoom(Vector2(3.5,3.5))
	ball.setup(player)
	camera.global_position = flag.global_position
	camera.lissing = lissingMap
	
#modulate = cor_rgb(255,255,0

func _process(delta: float) -> void:
	
	for guard in guards:
		guard.position = Vector2(100,-100)
	
	if cutScene:
		setPlayerSpawn()
		if (camera.global_position - player.global_position).length() < 100:
			cutScene = false 
		camera.lissing *= 1.005
		return
		
	if ball.state == ball.State.MOVING:
		const targetBallPor = 0.4
		camera.setExtPosComp(player.global_position + ball.mouseDis * targetBallPor)
		camera.lissing = 2.0
		var maxDis = (player.global_position - ball.global_position).length()
		var zoom_alvo = clamp(remap(maxDis, 100, 1000, 1.0, 0.5), 0, 19.0) * 3
		camera.setZoom(camera.zoomTarget.lerp(Vector2(zoom_alvo, zoom_alvo), delta * 2.0))
		if !ball.firstImpulsePassed:
			camera.start_shake(2,4)
			ball.firstImpulsePassed = true
	else:
		camera.setExtPosComp(Vector2.ZERO)
		camera.lissing += 2 * delta
		camera.lissing = clamp(camera.lissing,0,10)
		const normalZoom = 3.5
		camera.setZoom(camera.zoomTarget.lerp(Vector2(normalZoom,normalZoom), delta))
	
	self.limitWorld(player, delta)
	self.limitWorld(ball, delta)
	self.limitWorld(cart, delta)

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

func limitWorld(object : Character, delta : float) -> void:
	if object.global_position.x < 0:
		object.global_position.x -= object.velocity.x * delta
	elif object.global_position.x > roomSize.global_position.x:
		object.global_position.x -= object.velocity.x * delta
	
	if object.global_position.y < 0:
		object.global_position.y -= object.velocity.y * delta
	elif object.global_position.y > roomSize.global_position.y:
		object.global_position.y -= object.velocity.y * delta
	
	
