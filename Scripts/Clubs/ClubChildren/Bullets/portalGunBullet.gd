extends BaseBullet
class_name PortalGunBullet

func collide(area : Area2D):
	super.collide(area)
	var temp : Vector2 = area.get_parent().global_position
	area.get_parent().global_position = player.global_position
	player.global_position = temp
