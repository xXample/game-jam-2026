extends Node2D

@onready var mon_1 = $"Monster_1"
@onready var mon_2 = $"Monster_2"
@onready var mon_3 = $"Monster_3"
@onready var mon_4 = $"Monster_4"
@onready var monsters = [mon_1, mon_2, mon_3, mon_4]
var wacks = 20

func _ready() -> void:	
	pass

func game_over():
	get_tree().change_scene_to_file("res://Death.tscn")
	
func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://you-win.tscn")


const SPAWN_INTERVAL = 2.5
var spawn_timer = 0
var wack_timer = 0
func _process(delta: float) -> void:
	
	#TIMER SECTION
	if not $Timer.is_stopped():
		print("Time left: ", snapped($Timer.time_left, 1))	
	
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
	
	if roll <=   0.05: amount = 4
	elif roll <= 0.20: amount = 3
	elif roll <= 0.40: amount = 2
	else: amount = 1
	
	amount = min(amount, green_monsters.size())
	for i in range(amount):
		var monster = green_monsters.pick_random()
		monster.make_yellow()
		green_monsters.erase(monster)
	
