extends BaseBullet
class_name PortalGunBullet

func _ready() -> void:
	super._ready()
	self.damage = 20

func collide(area : Area2D):
	var parent : Movel = area.get_parent()
	self.player.enableCollision(true)
	parent.enableCollision(true)
	
	parent.takeDamage(self.damage)
	parent.collisionImpulse(Vector2.RIGHT.rotated(rotation) * 2)
	
	var temp : Vector2 = parent.global_position
	parent.call_deferred("set", "global_position", self.player.global_position)
	self.player.call_deferred("set", "global_position", temp)
	
	self.player.enableCollision(false)
	parent.enableCollision(false)
	# Remover a bala no próximo frame
	call_deferred("queue_free")
