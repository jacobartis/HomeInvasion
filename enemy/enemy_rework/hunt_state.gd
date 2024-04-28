extends EnemyState


func physics_process(delta):
	var player = body.player
	if player.hiding_spot:
		body.nav_agent.set_target_position(player.hiding_spot.global_position)
		if body.nav_agent.distance_to_target()<1.5:
			player.hiding_spot.search()
	else:
		body.nav_agent.set_target_position(player.global_position)
