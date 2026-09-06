extends ColorRect


@onready var shader_material = material


func _process(_delta):
	var mouse_position = get_global_mouse_position()

	shader_material.set_shader_parameter("mouse_position", mouse_position)
