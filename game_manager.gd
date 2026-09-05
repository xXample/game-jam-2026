extends Node


@onready var blocks = [
	$"../Block",
	$"../Block2",
	$"../Block3",
	$"../Block4"
]


const SPAWN_INTERVAL = 2.5

var spawn_timer = 0.0


func _process(delta):
	spawn_timer += delta

	if spawn_timer >= SPAWN_INTERVAL:
		spawn_timer = 0.0
		spawn_monsters()


func spawn_monsters():
	var available_blocks = []

	for block in blocks:
		if block.is_green():
			available_blocks.append(block)

	if available_blocks.size() == 0:
		return

	var roll = randf()
	var amount = 1

	if roll < 0.05:
		amount = 4
	elif roll < 0.20:
		amount = 3
	elif roll < 0.40:
		amount = 2
	else:
		amount = 1

	amount = min(amount, available_blocks.size())

	for i in range(amount):
		var block = available_blocks.pick_random()
		block.make_yellow()
		available_blocks.erase(block)
