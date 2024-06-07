extends EnemyState

var room
var section
var section_no = randi_range(1,3)
var hiding_no = randi_range(1,3)

func enter():
	print("Aggro")
	pick_room()

func process(delta):
	if body.get_director().get_pos_of_interest():
		return EnemyState.State.Invesigation
	
	if !room:
		return EnemyState.State.Idle
	
	if body.action_controller.process(delta):
		hiding_no -= 1
	
	if section_no <= 0:
		return EnemyState.State.Idle
	
	if body.get_section()==section and !body.action_controller.current_action:
		next_action()
	
	return EnemyState.State.None

func pick_room():
	var selection = body.director.get_close_rooms(0,30)
	if selection:
		room = selection.pick_random()
	else:
		room = body.director.get_player_room()
	if !room: return
	section_no = randi_range(1,room.get_sections().size())
	pick_section()

func pick_section():
	section = room.get_sections().pick_random()
	if !section:
		return
	var hs = section.get_hiding_spots(10000)
	if !hs.is_empty():
		hiding_no = randi_range(1,hs.size())
	body.nav_agent.set_target_position(section.global_position)

func next_action():
	var hs = section.get_hiding_spots(10000)
	if hs.is_empty() or hiding_no==0:
		section_no -= 1
		pick_section()
		return
	body.action_controller.enter({
		"action":EnemyAction.Actions.Search,
		"hiding_spot":hs.pick_random()
	})
