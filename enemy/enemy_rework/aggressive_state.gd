extends EnemyState

var target_room

func enter():
	print("Aggro")
	pick_room()

func process(delta):
	if !target_room:
		return EnemyState.State.Idle
	if body.get_room() == target_room:
		return EnemyState.State.Search
	return EnemyState.State.None

func pick_room():
	target_room = body.director.get_player_room()
	if !target_room:
		return
	body.nav_agent.set_target_position(target_room.global_position)

func exit():
	target_room = null
