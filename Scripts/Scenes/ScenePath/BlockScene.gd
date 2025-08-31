extends Node2D
class_name BlockScene

var function : int = 1
@onready var colRect : ColorRect = $col_rect
@onready var lab : Label = $lab

var mouseColission : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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
	
	if mouseColission:
		print('aaaaa')

func _on_area_2d_mouse_entered() -> void:
	mouseColission = true
	print()

func _on_area_2d_mouse_exited() -> void:
	mouseColission = false
	print('aaaa')
