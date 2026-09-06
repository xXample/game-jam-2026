extends "res://clickable.gd"

@onready var pink_sound: AudioStreamPlayer = $"pink_sound"

func _ready() -> void:
	super()
	$"Pink_collision".hide()
	$"Pink_collision".disabled = true

func _process(delta: float) -> void:
	if ($"Green_collision".is_visible_in_tree()):
		time_in_danger = 0
		return
	
	time_in_danger += delta
	if (time_in_danger >= TRANSITION_TIME):
		if ($"Yellow_collision".is_visible_in_tree()):
			make_red()
			time_in_danger = 0
		elif ($"Red_collision".is_visible_in_tree()):
			make_pink()
			time_in_danger = 0
		else:
			$"..".game_over()
			time_in_danger = 0 #for debugging
		

	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and get_parent().wacks > 0:
		get_parent().wacks -= 1
		#print(get_parent().wacks)
		if $"Pink_collision".is_visible_in_tree():
			health -= 1
			bounce_on_hit()
			if (health == 0):
				$"Pink_collision".hide()
				$"Pink_collision".disabled = true
				$"Red_collision".show()
				$"Red_collision".disabled = false
				const RED_HEALTH = 5
				health = RED_HEALTH
		elif $"Red_collision".is_visible_in_tree():
			health -= 1
			bounce_on_hit()
			if (health == 0):
				$"Red_collision".hide()
				$"Red_collision".disabled = true
				$"Yellow_collision".show()
				$"Yellow_collision".disabled = false
				const YELLOW_HEALTH = 3
				health = YELLOW_HEALTH
					
		elif $"Yellow_collision".is_visible_in_tree():
			health -= 1
			bounce_on_hit()
			if (health == 0):
				$"Yellow_collision".hide()
				$"Yellow_collision".disabled = true
				$"Green_collision".show()
				$"Green_collision".disabled = false
				const GREEN_HEALTH = 0
				health = GREEN_HEALTH
			
		
	

func bounce_on_hit():
	var original_y = position.y
	
	var tween = create_tween()
	tween.tween_property(self, "position:y", original_y + 15, 0.08)
	tween.tween_property(self, "position:y", original_y - 5, 0.08)
	tween.tween_property(self, "position:y", original_y, 0.1)


func make_pink():
	assert($"Red_collision".is_visible_in_tree())
	$"Red_collision".hide()
	$"Red_collision".disabled = true
	
	$"Pink_collision".show()
	$"Pink_collision".disabled = false
	health += 3
	pink_sound.play()
	
