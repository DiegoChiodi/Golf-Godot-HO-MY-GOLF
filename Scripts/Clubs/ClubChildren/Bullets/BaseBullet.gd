extends Node2D
class_name BaseBullet

var speed := Vector2(80,80)
var damage : float
var player : Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += speed * Vector2.from_angle(rotation) * delta

func collide(area: Area2D):
	area.get_parent().takeDamage(damage)
	area.get_parent().collisionImpulse(-Vector2.RIGHT.rotated(rotation) * 3)
	queue_free()

func _on_are_attack_area_entered(area: Area2D) -> void:
	if area.is_in_group("colHbAttack") and area.get_parent().is_in_group("enemy"):
		collide(area)

func setup(_damage : float, _player : Player):
	damage = _damage
	if _player != null:
		player = _player
