extends Node2D

@onready var leftHand = $spr_leftHand
@onready var rightHand = $spr_rightHand
@onready var area_attack : Area2D = $are_attack
@onready var colLeft = $are_attack/col_attack
@onready var colRight = $are_attack/col_attack2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setup(_player : Player) -> void:
	self.leftHand.setup(_player)
	self.rightHand.setup(_player)
