extends EnemyState

#Makes noises and triggers vents to confuse the player and mask it's location.

var quant: int = 5
var current: int = 0
var delay: float = 2
var timer: float = 0

func enter():
	interact_target = body.get_director().get_nearest_vent().front()
	current = 0
	timer = delay

func process(delta):
	timer -= delta
	if current >= quant:
		body.get_director().get_vent_nearest_player().pick_random().exit(body,randi()%2==0)
		return EnemyState.State.Idle
	if body.in_vent and timer<=0:
		body.get_director().get_vent_nearest_player().pick_random().fake(randi()%2==0)
		current += 1
		timer = delay*randf_range(.5,1)
	return EnemyState.State.None
