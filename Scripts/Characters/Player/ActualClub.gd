extends Node2D
class_name ActualClub
var player : Player
var golfClub1 : BaseClub
var golfClub2 : BaseClub

var actualClub
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("right_click"):
		if actualClub == golfClub1:
			remove_child(actualClub)
			actualClub = golfClub2
		else: #actualClub == golfClub2:
			remove_child(golfClub2)
			actualClub = golfClub1
		add_child(actualClub)
		actualClub.setAngle()

func setup(_player : Player) -> void:
	player = _player
	var club_scene := load("res://Scenes/GolfClub.tscn")
	golfClub1 = club_scene.instantiate()
	golfClub2 = club_scene.instantiate()
	golfClub1.setup(player)
	golfClub2.setup(player)
	actualClub = golfClub1
	add_child(actualClub)
