extends BaseClub
class_name portalGun

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	self.damage = 10.0
	self.attackDelay = 0.8
	self.forceInBall = 200
	self.maxForce = self.forceInBall
	self.shotForm = self.ShotForm.RANGE
	bullet = preload("res://Scenes/Clubs/Bullets/PortalGunBullet.tscn")
	spawnTiro = $spawn_tiro
	
	
func bulletSetup(bullet) -> void:
	bullet.setup(self.damage, self.player, self)
