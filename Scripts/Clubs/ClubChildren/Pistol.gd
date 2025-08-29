extends BaseClub
class_name Pistol

func _ready() -> void:
	super._ready()
	self.damage = 10.0
	self.attackDelay = 0.5
	self.forceInBall = 200
	self.shotForm = self.ShotForm.RANGE
	bullet = preload("res://Scenes/Clubs/Bullets/Bullet.tscn")
	spawnTiro = $spawn_tiro
