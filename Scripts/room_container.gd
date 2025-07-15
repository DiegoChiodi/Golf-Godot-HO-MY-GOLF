extends Node2D

func trocar_sala(path, player, camera):
	var nova_sala = load(path).instantiate()
	if nova_sala is BaseScene:
		nova_sala.setup(player, camera)
	add_child(nova_sala)
