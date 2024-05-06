extends EnemyState

func enter():
	$Timer.start(1)
	body.nav_agent.set_target_position(body.get_director().get_player_pos())

func process(delta):
	body.set_sprinting(true)
	var hiding_spot = body.get_director().get_player_hiding_spot()
	if hiding_spot:
		if !body.action_controller.process(delta):
			body.action_controller.enter({
			"action":EnemyAction.Actions.Search,
			"hiding_spot":hiding_spot
			})
	
	if $Timer.is_stopped() and body.nav_agent.is_navigation_finished():
		return EnemyState.State.Aggressive
	return EnemyState.State.None


