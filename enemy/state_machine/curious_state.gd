extends EnemyState

var target_room

func enter():
	pick_room()
	print("Curious")

func process(delta):
	if body.get_director().get_pos_of_interest():
		return EnemyState.State.Invesigation
	if !target_room:
		return EnemyState.State.Idle
	if body.get_room() == target_room and !body.action_controller.current_action:
		body.action_controller.enter({
			"action":EnemyAction.Actions.Search,
			"hiding_spot":target_room.get_hiding_spots().pick_random()
		})
	var result = body.action_controller.process(delta)
	if result:
		return EnemyState.State.Idle
	return EnemyState.State.None

func pick_room():
	var rooms = body.director.get_close_rooms(10,50)
	if rooms.is_empty():
		return
	target_room = rooms.pick_random()
	body.nav_agent.set_target_position(target_room.get_rand_pos())
