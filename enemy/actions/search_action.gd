extends EnemyAction

var hiding_spot

func enter(args:Dictionary):
	hiding_spot = args["hiding_spot"]
	body.nav_agent.set_target_position(hiding_spot.get_interaction_spot_pos())

func process(delta):
	if !hiding_spot:
		push_warning("No hiding spot given")
		return true
	
	if !body.nav_agent.is_navigation_finished(): return false
	
	if !is_correct_anim():
		search_hiding_spot(hiding_spot)
	elif !body.animation_player.is_playing():
		return true
	
	return false

func search_hiding_spot(target):
	if body.animation_player.current_animation == "search": return
	body.animation_player.play("search")
	target.search()

func is_correct_anim():
	return body.animation_player.current_animation == "search" or body.animation_player.current_animation == ""
