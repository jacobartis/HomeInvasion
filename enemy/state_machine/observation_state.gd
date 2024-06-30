extends EnemyState

#Stares down the player from a distance
#Chases or retreats if stared at for too long

var seen: bool = false
var total_dur:float = 0
var look_dur:float = 0
var max_duration:float = 20
var aggro_time:float = 5

func enter():
	print("Observation")
	seen = false
	total_dur = 0
	look_dur = 0

func process(delta):
	if !seen:
		seen = body.get_visible_notifier().is_on_screen()
	else:
		look_dur += delta
	total_dur += delta
	if seen and !body.get_visible_notifier().is_on_screen():
		return EnemyState.State.Idle
	elif look_dur >= aggro_time:
		return EnemyState.State.Chase
	if total_dur>=max_duration:
		return EnemyState.State.Idle
	body.look_at(body.get_director().get_player_pos())
	body.rotation.x = 0
	body.rotation.z = 0
	return EnemyState.State.None
