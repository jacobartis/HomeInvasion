extends EnemyState

signal entered_state(state)

@onready var states = {
	EnemyState.State.Idle: $IdleState,
	EnemyState.State.Absent: $AbsentState,
	EnemyState.State.Observation: $ObservationState,
	EnemyState.State.Confusion: $ConfusionState,
	EnemyState.State.Chase: $ChaseState,
	EnemyState.State.Ambush:$AmushState,
	EnemyState.State.Prowling:$ProwlingState,
	EnemyState.State.Intimidation:$IntimidationState,
}

var current_state: EnemyState

func init(new_body):
	super(new_body)
	for state in states:
		states[state].init(new_body)
	change_state(EnemyState.State.Idle)

func process(delta):
	var new_state = current_state.process(delta)
	if new_state == EnemyState.State.None:
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

func _on_ray_cast_3d_player_enter_view():
	#if body.peaceful:return
	if randi()%1==0:
		change_state(EnemyState.State.Observation)
	else:
		change_state(EnemyState.State.Chase)
