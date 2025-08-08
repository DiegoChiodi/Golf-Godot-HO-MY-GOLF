extends Node2D

var speed := Vector2(80,80)
var damage : float = 20.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += speed * Vector2.from_angle(rotation) * delta

func _on_are_attack_area_entered(area: Area2D) -> void:
	if area.is_in_group("colHb") and area.get_parent().is_in_group("enemy"):
		area.get_parent().takeDamage(damage, -Vector2.RIGHT.rotated(rotation) * 4)
		queue_free()
