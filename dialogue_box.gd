extends Control

signal dialogue_started
signal dialogue_finished

@onready var label = $Panel/Label
@onready var button = $Panel/Button
var dialogue = []
var current_line = 0

func _ready():
	hide()
	button.pressed.connect(_next_dialogue)

func show_dialogue(lines):
	dialogue = lines
	current_line = 0
	label.text = dialogue[current_line]
	show()
	dialogue_started.emit()

func _next_dialogue():
	current_line += 1
	if current_line >= dialogue.size():
		hide()
		dialogue_finished.emit()
	else:
		label.text = dialogue[current_line]
