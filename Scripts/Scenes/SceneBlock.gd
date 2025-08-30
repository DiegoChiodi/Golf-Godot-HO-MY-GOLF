extends Node2D
class_name SceneBlock

var function : int = 1
@onready var colRect : ColorRect = $col_rect
@onready var lab : Label = $lab
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if function != null:
		match function:
			1:
				colRect.modulate = Color(0.0, 0.3, 0.6) # mais azulado
				lab.text = 'Batalha'
			2:
				colRect.modulate = Color(0.5, 1.0, 0.5) # verde claro
				lab.text = 'Loja'
			3:
				colRect.modulate = Color(0.6, 1.0, 0.3) # verde amarelado
				lab.text = 'Boss'
			4:
				colRect.modulate = Color(0.2, 1.0, 0.2) # verde saturado
				lab.text = 'Báu do tesouro'
				
