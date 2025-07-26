extends Node
class_name ClubsManager

enum Clubs { HAND, GOLFCLUB, PISTOL}

var club_1 = Clubs.HAND;
var club_2 = Clubs.HAND;

var actualClub = club_1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
