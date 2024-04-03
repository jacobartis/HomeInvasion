extends Node

var state_controller:Node

func physics_process(delta):
	var body = state_controller.body
	var player = body.player
	if player.hiding_spot:
		state_controller.nav_agent.set_target_position(player.hiding_spot.global_position)
		if state_controller.nav_agent.distance_to_target()<1.5:
			player.hiding_spot.search()
	else:
		state_controller.nav_agent.set_target_position(player.global_position)
	
	body.rotation.x = 0
	body.rotation.z = 0
	state_controller.body.look_at(state_controller.nav_agent.get_next_path_position())
	body.velocity += body.transform.basis * Vector3(0,0,-body.speed*1.5)
