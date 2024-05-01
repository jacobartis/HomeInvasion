extends EnemyState

var start_status: Status = Status.idle

func enter():
	$Timer.start(2)
	start_status = Status.idle

func process(delta):
	var hiding_spot = body.get_director().get_player_hiding_spot()
	if hiding_spot:
		body.nav_agent.set_target_position(hiding_spot.global_position)
		if body.nav_agent.distance_to_target()<1.5:
			search_hiding_spot(hiding_spot)
	else:
		body.nav_agent.set_target_position(body.get_director().get_player_pos())
	if $Timer.is_stopped():
		return EnemyState.State.Idle
	return EnemyState.State.None

func search_hiding_spot(hiding_spot):
	hiding_spot.search()
	body.animation_player.play("search")
	start_status = Status.active
