extends Line2D

var target_body = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta):
	if is_instance_valid(target_body):
		# Mantém a posição mas ignora a rotação
		global_position = target_body.global_position
		rotation = 0  # Força rotação zero
