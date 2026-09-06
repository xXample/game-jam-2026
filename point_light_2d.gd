extends PointLight2D

func _process(_delta: float) -> void:

	global_position = get_global_mouse_position()
	

	global_rotation = 0.0
