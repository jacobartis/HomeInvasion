extends EnemyState

func enter():
	set_target()

func process(delta):
	body.set_sprinting(true)
	if body.nav_agent.target_position != body.get_director().get_pos_of_interest():
		set_target()
	if !body.get_director().get_pos_of_interest() or not body.nav_agent.is_target_reachable():
		return EnemyState.State.Idle
	if body.nav_agent.is_navigation_finished():
		return EnemyState.State.Idle
	return EnemyState.State.None

func exit():
	super()
	body.get_director().set_pos_of_interest(Vector3.ZERO)

func set_target():
	body.nav_agent.set_target_position(body.get_director().get_pos_of_interest())
