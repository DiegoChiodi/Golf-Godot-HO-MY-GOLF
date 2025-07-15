extends BaseScene
class_name WorldContainer

func trade_room(path, player, camera):
	var new_room = load(path).instantiate()
	if new_room is BaseScene:
		new_room.setup(player, camera)
	add_child(new_room)
