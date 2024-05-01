extends EnemyState

var target_room

func enter():
	pick_room()
	print("Curious")

func process(delta):
	if !target_room:
		return EnemyState.State.Idle
	if body.get_room() == target_room:
		return EnemyState.State.Search
	return EnemyState.State.None

func pick_room():
	var rooms = body.director.get_close_rooms(1000,10)
	if rooms.is_empty():
		return
	target_room = rooms.pick_random()
	body.nav_agent.set_target_position(target_room.get_rand_pos())

func exit():
	target_room = null
