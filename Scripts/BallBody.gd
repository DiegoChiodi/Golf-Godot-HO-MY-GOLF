extends CharacterBody2D

@onready var lblDebug : Label = $lbl_debug
@onready var bodBall : CharacterBody2D = $bod_ball

@onready var iniMousePos
@onready var endMousePos
@onready var clicked = false
@onready var soltClick = false
@onready var mouseDir
@onready var colPlayer = false

func _process(delta: float) -> void:
	if colPlayer:
		if Input.is_action_just_pressed("left_click"):
			iniMousePos = get_global_mouse_position()
			lblDebug.text = str(iniMousePos)
			clicked = true
		if clicked && Input.is_action_just_released("left_click"):
			lblDebug.text = "les go"
			endMousePos = get_global_mouse_position()
			soltClick = true
		if soltClick:
			mouseDir = (endMousePos - iniMousePos).normalized()
			lblDebug.text = str(mouseDir)
			soltClick = false
			clicked = false

func _on_area_entered(area: Area2D) -> void:
	colPlayer = true

func _on_area_exited(area: Area2D) -> void:
	colPlayer = false
