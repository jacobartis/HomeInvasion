extends EnemyState

#Hunts down the player in intence chases
#May use tactics to catch the player off guard (using vents to cut the player off)
#Makes lots of noise

var timer = 0
var in_view

func enter():
	in_view = true
	

func process(delta):
	if in_view:
		timer = 1
	
	body.set_sprinting(true)
	var hiding_spot = body.get_director().get_player_hiding_spot()
	if hiding_spot:
		interact_target = hiding_spot
	else:
		interact_target = null
		body.nav_agent.set_target_position(body.get_director().get_player_pos())
	
	if timer<=0 and body.nav_agent.is_navigation_finished():
		return EnemyState.State.Idle
	timer -= delta
	return EnemyState.State.None

func _on_ray_cast_3d_player_exit_view():
	in_view = false

func _on_ray_cast_3d_player_enter_view():
	in_view = true
