extends Node2D
class_name BlockScene

var function : int = 1
@onready var colRect : ColorRect = $col_rect
@onready var lab : Label = $lab

var mouseColission : bool

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if function != null:
		lab.text = str(function)
		match function:
			1:
				colRect.modulate = Color(0.0, 0.3, 0.6) # mais azulado
			2:
				colRect.modulate = Color(0.5, 1.0, 0.5) # verde claro
			3:
				colRect.modulate = Color(0.6, 1.0, 0.3) # verde amarelado
			4:
				colRect.modulate = Color(0.2, 1.0, 0.2) # verde saturado
	var mouse_pos = get_global_mouse_position()
	if colRect.get_global_rect().has_point(mouse_pos):
		mouseColission = true
	else:
		mouseColission = false
	
