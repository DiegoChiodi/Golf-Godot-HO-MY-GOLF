extends Node2D
class_name Obstacle
@onready var colHb : Area2D = $Area2D
@onready var sprite : Sprite2D = $Sprite2D
var lessing : float = 5
var dir : Vector2
var forceImpact : float
var breaked : bool = false
var fallingLissing : float = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	self.forceImpact = lerp(self.forceImpact, 0.0, lessing * delta)
	position += forceImpact * dir * delta
	if !breaked:
		return
	if dir.x > 0:
		rotation_degrees = lerp(rotation_degrees, 90.0, fallingLissing * delta)
	else:
		rotation_degrees = lerp(rotation_degrees, -90.0, fallingLissing * delta)



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("colHbAttack") and !breaked:
		dir = (global_position - area.get_parent().global_position).normalized()
		self.forceImpact = 80.0
		breaked = true
