extends BaseClub
class_name Pistol

var bullet = preload("res://Scenes/Clubs/Bullets/Bullet.tscn")
@onready var spawnTiro = $spawn_tiro

func attackGo() -> void:
	var world = game_manager.worldContainer.currentRoom
	var bulletIns = bullet.instantiate()
	bulletIns.position = world.to_local(spawnTiro.global_position)
	bulletIns.rotation = self.rotation
	world.add_child(bulletIns)
