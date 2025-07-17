extends BaseScene
class_name WorldContainer

func load_room(path : String, player : Player, camera) -> void:
	var new_room = load(path).instantiate()
	if new_room is BaseScene:
		new_room.setup(player, camera)
	add_child(new_room)

func destroy_room(path : String) -> void:
	pass
