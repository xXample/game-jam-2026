extends Node2D
@onready var dialogue_box = $CanvasLayer/DialogueBox
@onready var mari_doll = $MariDoll
@onready var madoka_doll = $MadokaDoll 
@onready var kyoko_doll = $KyokoDoll 
@onready var fade_rect = $CanvasLayer/FadeRect

var all_dolls_dialogue_shown = false
var bedtime_dialogue_shown = false

func _ready():
	dialogue_box.dialogue_started.connect(_on_dialogue_started)
	dialogue_box.dialogue_finished.connect(_on_dialogue_finished)
	
	dialogue_box.show_dialogue([
		"Oh no! The princesses need my help! (Click here to continue.)",
		"I need to save them with my magic.",
		"(Click the three dolls with the wand) "
	])

func _on_dialogue_started():
	mari_doll.input_pickable = false
	madoka_doll.input_pickable = false
	kyoko_doll.input_pickable = false

func _on_dialogue_finished():
	mari_doll.input_pickable = true
	madoka_doll.input_pickable = true
	kyoko_doll.input_pickable = true
	
	if bedtime_dialogue_shown:
		_fade_and_change_scene()

func _process(delta):
	if not all_dolls_dialogue_shown and mari_doll.mariclicked and madoka_doll.madokaclicked and kyoko_doll.kyokoclicked:
		all_dolls_dialogue_shown = true
		bedtime_dialogue_shown = true
		dialogue_box.show_dialogue([
			"It's getting late, it's time to go to bed!",
		])

func _fade_and_change_scene():
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 1.5)
	tween.tween_callback(func(): get_tree().change_scene_to_file("res://main.tscn"))
