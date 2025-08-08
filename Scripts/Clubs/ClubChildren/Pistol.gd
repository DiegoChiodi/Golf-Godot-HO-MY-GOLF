extends BaseClub
class_name Pistol

var bullet = preload("res://Scenes/Clubs/Bullets/Bullet.tscn")
@onready var spawnTiro = $spawn_tiro

func pressMouse() -> void:
	var world = game_manager.worldContainer.currentRoom
	var bulletIns = bullet.instantiate()
	bulletIns.position = world.to_local(global_position)
	bulletIns.rotation = self.rotation
	world.add_child(bulletIns)
