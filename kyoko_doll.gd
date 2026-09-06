extends Area2D

@export var normal_texture: Texture2D
@export var hover_texture: Texture2D
@export var clicked_texture: Texture2D

@onready var sprite = $Sprite2D

var kyokoclicked = false

func _ready():
	sprite.texture = normal_texture
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	input_event.connect(_on_input_event)

func _on_mouse_entered():
	if not kyokoclicked:
		sprite.texture = hover_texture

func _on_mouse_exited():
	if not kyokoclicked:
		sprite.texture = normal_texture

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		kyokoclicked = true
		sprite.texture = clicked_texture
