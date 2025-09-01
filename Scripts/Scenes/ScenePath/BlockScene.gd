extends Node2D
class_name BlockScene

var function : int = 0
@onready var colRect : ColorRect = $col_rect
@onready var lab : Label = $lab

@export var initial : bool = false
@export var finish : bool = false

var mouseColission : bool

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	if initial:
		function = 0
func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	if colRect.get_global_rect().has_point(mouse_pos):
		mouseColission = true
	else:
		mouseColission = false

func setFunction() -> void:
	if initial:
		function = 0
	elif finish:
		function = 5
	
	lab.text = str(function)
	match function:
		0:
			lab.modulate = Color(0,0,0)
		1:
			colRect.modulate = Color(1.0, 0.3, 0.3) # mais azulado
		2:
			colRect.modulate = Color(0.5, 1.0, 0.5) # verde claro
		3:
			colRect.modulate = Color(0.6, 1.0, 0.3) # verde amarelado
			lab.text = '?'
		4:
			colRect.modulate = Color(0.2, 1.0, 0.2) # verde saturado
		5:
			colRect.modulate = Color(1, 0, 0)
