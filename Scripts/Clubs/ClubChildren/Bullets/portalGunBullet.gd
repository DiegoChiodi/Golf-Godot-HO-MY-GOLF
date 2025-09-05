extends BaseBullet
class_name PortalGunBullet

var destructSelf : bool = false

func _ready() -> void:
	super._ready()
	self.damage = 20
	self.speed = Vector2(120,120)
	self.maxForce = 200

func collide(area : Area2D):
	if !destructSelf:
		var parent : Character = area.get_parent()
		self.player.enableCollision(true)
		parent.enableCollision(true)
		
		parent.takeDamage(self.damage)
		parent.collisionImpulse(Vector2.RIGHT.rotated(rotation) * 2)
		
		var temp : Vector2 = parent.global_position
		parent.call_deferred("set", "global_position", self.player.global_position)
		self.player.call_deferred("set", "global_position", temp)
		
		self.player.enableCollision(false)
		parent.enableCollision(false)
		
		destructSelf = true
		club.attackWait = club.attackDelay
		# Remover a bala no próximo frame
		call_deferred("queue_free")
