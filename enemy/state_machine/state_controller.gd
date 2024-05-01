extends EnemyState

signal entered_state(state)

@onready var states = {
	EnemyState.State.Idle: $IdleState,
	EnemyState.State.Curious: $CuriousState,
	EnemyState.State.Aggressive: $AggressiveState,
	EnemyState.State.Tactical: $TacticalState,
	EnemyState.State.Search: $SearchState,
	EnemyState.State.Chase: $ChaseState,
	EnemyState.State.Invesigation: $InvestigationState,
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

func _on_ray_cast_3d_player_seen():
	change_state(EnemyState.State.Chase)
