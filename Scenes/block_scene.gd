extends Area2D

var collision : CollisionShape2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision = CollisionShape2D.new()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	position.y += 1
