extends Area2D

@export var normal_texture: Texture2D
@onready var sprite = $Sprite2D

func _ready():
	sprite.texture = normal_texture
	input_pickable = false   # <-- add this
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(event):
	if event is InputEventMouseMotion:
		position = event.position
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			sprite.rotation_degrees = -100
		else:
			sprite.rotation_degrees = -71
