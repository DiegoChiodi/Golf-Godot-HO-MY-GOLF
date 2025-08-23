extends BaseClub
class_name portalGun

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.damage = 10
	self.attackDelay = 1
	self.forceInBall = 200
	self.shotForm = self.ShotForm.RANGE
	bullet = preload("res://Scenes/Clubs/Bullets/PortalGunBullet.tscn")
	spawnTiro = $spawn_tiro
	
	
func bulletSetup(bullet) -> void:
	bullet.setup(self.damage, self.player)
