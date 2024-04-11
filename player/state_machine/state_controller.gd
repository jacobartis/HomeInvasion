extends PlayerState

signal entered_state(state)

@onready var states = {
	PlayerState.State.Idle: $Idle,
	PlayerState.State.Walking: $Walking,
	PlayerState.State.Sprint: $Sprint,
	PlayerState.State.Hiding: $Hiding,
}

var current_state: PlayerState

func init(new_body):
	super(new_body)
	for state in states:
		states[state].init(new_body)
	change_state(PlayerState.State.Idle)

func process(delta):
	var new_state = current_state.process(delta)
	if new_state == PlayerState.State.None:
		return
	change_state(new_state)

func change_state(new_state):
	if current_state:
		current_state.exit()
	current_state = states[new_state]
	current_state.enter()
	emit_signal("entered_state",current_state)

func physics_process(delta):
	current_state.physics_process(delta)

func input(event):
	current_state.input(event)
