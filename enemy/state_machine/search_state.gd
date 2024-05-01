extends EnemyState

var hiding_spot
var start_status: Status = Status.idle

func init(new_body):
	super(new_body)
	body.animation_player.connect("animation_finished",animation_finished)

func enter():
	start_status = Status.idle
	find_hiding_spot()

func process(delta):
	if !hiding_spot:
		return EnemyState.State.Idle
	if body.nav_agent.is_navigation_finished() and start_status==Status.idle:
		search_hiding_spot(hiding_spot)
	if start_status==Status.finished:
		return EnemyState.State.Idle
	return EnemyState.State.None

func exit():
	hiding_spot = null

func find_hiding_spot():
	if !body.get_room():
		return
	if body.get_room().get_hiding_spots().is_empty():
		return
	hiding_spot = body.get_room().get_hiding_spots().pick_random()
	body.nav_agent.set_target_position(hiding_spot.get_interaction_spot_pos())

func search_hiding_spot(hiding_spot):
	hiding_spot.search()
	body.animation_player.play("search")
	start_status = Status.active

func animation_finished(animation_name:String):
	if animation_name.contains("search"):
		start_status = Status.finished
