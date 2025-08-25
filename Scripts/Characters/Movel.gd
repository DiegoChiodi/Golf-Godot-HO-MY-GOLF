extends Character
class_name Movel

@onready var frameDim = Vector2.ZERO
@onready var areAttackHitBox : Area2D = $are_hbAttack
@onready var colAttackHitBox : CollisionShape2D = $are_hbAttack/col_hb
var sliceX = 1
var sliceY = 1

func _ready() -> void:
	super._ready()
	frameDim = Vector2(drawSelf.texture.get_size().x / sliceX, drawSelf.texture.get_size().y / sliceY)

func _process(delta: float) -> void:
	super._process(delta)
	if direction.length() > 0.1:  # Threshold para considerar movimento
		drawSelfDir()
	else:
		stop()
	
	if move_direction.length() > 0.1:  # Threshold para considerar movimento
		swing(delta)
	else:
		drawSelf.rotation_degrees = lerp(drawSelf.rotation_degrees, 0.0, 0.05)

func _physics_process(delta: float) -> void:
	direction = setDirection()
	super._physics_process(delta)

func _on_are_hb_attack_area_entered(area: Area2D) -> void:
	if area.is_in_group("colHbAttack") and area.get_parent().is_in_group(groupRival):
		colRival = true
		colRivalId = area.get_parent()
		
func _on_are_hb_attack_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group(groupRival):
		colRival = false

func drawSelfDir():
	if abs(direction.x) > abs(direction.y):
		runRight()
		drawSelf.flip_h = direction.x < 0  # Flip apenas no X
	else:
		if direction.y < 0:
			runUp()  # Animação para cima
		else: 
			runDown()

func runRight():
	drawSelf.region_rect = Rect2(Vector2(0, 0), frameDim) 
	#O y do vetor vale 0 por causa que é para direita

func runDown():
	drawSelf.region_rect = Rect2(Vector2(0, frameDim.y * 1), frameDim)
	
func runUp():
	drawSelf.region_rect = Rect2(Vector2(0, frameDim.y * 2), frameDim)

func enableCollision(definition : bool) -> void:
	super.enableCollision(definition)
	colAttackHitBox.set_deferred("disabled", definition)
	areAttackHitBox.set_deferred("monitorable", !definition)
	areAttackHitBox.set_deferred("monitoring", !definition)	
