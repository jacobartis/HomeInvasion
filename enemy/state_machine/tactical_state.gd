extends EnemyState

var target_room

func enter():
	pick_room()
	print("Tactical")

func process(delta):
	if !target_room:
		return EnemyState.State.Idle
	if body.get_room() == target_room:
		return EnemyState.State.Search
	return EnemyState.State.None

func pick_room():
	var rooms = body.director.get_common_rooms()
	if rooms.is_empty():
		return
	target_room = rooms[0]
	body.nav_agent.set_target_position(
		target_room.get_closest_section(body.global_position).global_position)

func exit():
	target_room = null
