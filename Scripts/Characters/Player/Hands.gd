extends Node2D

@onready var leftHand = $spr_leftHand
@onready var rightHand = $spr_rightHand
@onready var area_attack : Area2D = $are_attack
@onready var colLeft = $are_attack/col_attack
@onready var colRight = $are_attack/col_attack2
var player : Player

func setup(_player : Player) -> void:
	self.player = _player
	self.leftHand.setup(_player)
	self.rightHand.setup(_player)
