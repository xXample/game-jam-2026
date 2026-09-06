extends Node2D

@onready var mon_1 = $"Madoka"
@onready var mon_2 = $"Mami"
@onready var mon_3 = $"Kyoko"
@onready var mon_4 = $"Mirror"
@onready var dialogue_box = $CanvasLayer/DialogueBox

@onready var monsters = [mon_1, mon_2, mon_3, mon_4]
#@onready var monsters = [mon_2]
var wacks = 20

func _ready():
	
	dialogue_box.show_dialogue([
		"What happened? There's monsters!!!",
		"Good thing I remember how to use my wand.",
		"(Click the three dolls with the wand)"
	])

func game_over():
	get_tree().change_scene_to_file("res://Death.tscn")
	
func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://you-win.tscn")


const SPAWN_INTERVAL = 2.5
var spawn_timer = 0
var wack_timer = 0
func _process(delta: float) -> void:
	
	#FLASHLIGHT BRIGHTNESS SECTION
	var score_ratio: float = clamp(wacks / 20.0, 0, 0.1)
	$"PointLight2D".energy = 20.0 * score_ratio

	
	#TIMER SECTION
	if not $Timer.is_stopped():
		#print("Time left: ", snapped($Timer.time_left, 1))	
		$RichTextLabel.text = str(snapped($Timer.time_left, 1))
	
	#WACK SECTION
	wack_timer += delta
	if (wack_timer >= 0.5):	
		wacks = min(20, wacks + 1)
		wack_timer = 0
	
	#SPAWN SECTION
	spawn_timer += delta
	if spawn_timer >= SPAWN_INTERVAL:
		spawn_timer = 0.0
		spawn_monsters()
	
func spawn_monsters():
	var green_monsters = []
	for m in monsters:
		if m.get_node("Green_collision").is_visible_in_tree():
			green_monsters.append(m)
	
	var roll = randf()
	var amount = -1
	
	if (snapped($Timer.time_left, 1) <= 60):
		if roll <=   0.05: amount = 4
		elif roll <= 0.20: amount = 3
		elif roll <= 0.40: amount = 2
		else: amount = 1
	else:
		if roll <= 0.10: amount = 3
		elif roll <= 0.20: amount = 2
		else: amount = 1
	
	amount = min(amount, green_monsters.size())
	for i in range(amount):
		var monster = green_monsters.pick_random()
		monster.make_yellow()
		green_monsters.erase(monster)
	
