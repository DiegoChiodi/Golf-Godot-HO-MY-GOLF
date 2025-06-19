extends "res://Scripts/IntercatArea.gd"
# Called when the node enters the scene tree for the first time.
@onready var lblDebug : Label = $lbl_debug

@onready var click = 0
@onready var iniMousePos

@onready var clicked = false
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if colPlayer:
		if Input.is_action_just_pressed("left_click"):
			iniMousePos = get_global_mouse_position()
			lblDebug.text = str(iniMousePos)
			clicked = true
		if clicked && Input.is_action_just_released("left_click"):
			lblDebug.text = "les go"
		
