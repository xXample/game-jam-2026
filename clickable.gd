extends Area2D

var health = 0
var time_in_danger = 0
const TRANSITION_TIME = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("game start")
	#$"Green_collision".hide()
	#$"Green_collision".disabled = true
	$"Yellow_collision".hide()
	$"Yellow_collision".disabled = true
	$"Red_collision".hide()
	$"Red_collision".disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ($"Green_collision".is_visible_in_tree()):
		time_in_danger = 0
		return
	
	time_in_danger += delta
	if (time_in_danger >= TRANSITION_TIME):
		if ($"Yellow_collision".is_visible_in_tree()):
			make_red()
			time_in_danger = 0
		#else:
			#$"..".game_over()
			#time_in_danger = 0 #for debugging
		
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and get_parent().wacks > 0:
		get_parent().wacks -= 1
		#print(get_parent().wacks)
		if $"Red_collision".is_visible_in_tree():
			health -= 1
			if (health == 0):
				$"Red_collision".hide()
				$"Red_collision".disabled = true
				$"Yellow_collision".show()
				$"Yellow_collision".disabled = false
				const YELLOW_HEALTH = 3
				health = YELLOW_HEALTH
					
		elif $"Yellow_collision".is_visible_in_tree():
			health -= 1
			if (health == 0):
				$"Yellow_collision".hide()
				$"Yellow_collision".disabled = true
				$"Green_collision".show()
				$"Green_collision".disabled = false
				const GREEN_HEALTH = 0
				health = GREEN_HEALTH
			
		
	
func make_yellow():
	assert($"Green_collision".is_visible_in_tree())
	$"Green_collision".hide()
	$"Green_collision".disabled = true
	
	$"Yellow_collision".show()
	$"Yellow_collision".disabled = false
	health = 3

func make_red():
	assert($"Yellow_collision".is_visible_in_tree())
	$"Yellow_collision".hide()
	$"Yellow_collision".disabled = true
	
	$"Red_collision".show()
	$"Red_collision".disabled = false
	health += 5

#func game_over():
	#print("Game Over")
	#set_process(false)
	
