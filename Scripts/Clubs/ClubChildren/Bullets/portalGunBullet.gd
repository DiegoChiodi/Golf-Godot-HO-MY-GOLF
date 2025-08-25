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
	parent.global_position = self.player.global_position
	self.player.global_position = temp
	queue_free()
