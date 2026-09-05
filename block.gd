extends Control


enum State {
	GREEN,
	YELLOW,
	RED
}


var state = State.GREEN
var clicks = 0
var time_in_state = 0.0




const YELLOW_CLICKS = 3
const RED_CLICKS = 6

const YELLOW_TIME = 5.0
const RED_TIME = 5.0


@onready var placeholder = $Placeholder
@onready var click_area = $ClickArea




func _ready():
	click_area.pressed.connect(_on_click)
	set_state(State.GREEN)


func _process(delta):
	# Increase the random spawn timer


	# Count time while yellow or red
	if state == State.YELLOW or state == State.RED:
		time_in_state += delta


	# Yellow → Red after 5 seconds
	if state == State.YELLOW:
		if time_in_state >= YELLOW_TIME:
			set_state(State.RED)


	# Red → Game Over after 5 seconds
	elif state == State.RED:
		if time_in_state >= RED_TIME:
			game_over()


func _on_click():
	if state == State.YELLOW:
		clicks += 1
		print("Yellow clicks: ", clicks)

		if clicks >= YELLOW_CLICKS:
			set_state(State.GREEN)

	elif state == State.RED:
		clicks += 1
		print("Red clicks: ", clicks)

		if clicks >= RED_CLICKS:
			set_state(State.YELLOW)


func set_state(new_state):
	state = new_state
	clicks = 0
	time_in_state = 0.0

	match state:
		State.GREEN:
			placeholder.color = Color.GREEN
			print("State: GREEN")

		State.YELLOW:
			placeholder.color = Color.YELLOW
			print("State: YELLOW")

		State.RED:
			placeholder.color = Color.RED
			print("State: RED")


func game_over():
	print("GAME OVER")
	set_process(false)
	
func is_green():
	return state == State.GREEN


func make_yellow():
	set_state(State.YELLOW)
