extends EnemyState

#Just leaves, gives player no information.

var timer = 0

func enter():
	interact_target = body.get_director().get_nearest_vent().front()
	timer = randf_range(5,10)

func process(delta):
	timer -= delta
	if body.in_vent and timer<=0:
		body.get_director().get_vent_nearest_player().front().exit(body,false)
		return EnemyState.State.Idle
	return EnemyState.State.None
