extends Node2D

@onready var colHb : Area2D = $Area2D
var lessing : float= 5
var dir : Vector2
var forceImpact : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.forceImpact = lerp(self.forceImpact, 0.0, lessing * delta)
	position += forceImpact * dir * delta


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("colHbAttack"):
		dir = (global_position - area.get_parent().global_position).normalized()
		self.forceImpact = 20.0
