extends EnemyState

var target_room

var target_interactable: Node3D : set=set_target_interactable

func set_target_interactable(new):
	if target_interactable:
		target_interactable.get_node("InteractionArea").body_entered.disconnect(self_entered_interaction)
	
	target_interactable = new
	if !target_interactable: return
	
	if not (target_interactable.has_node("InteractionArea") and target_interactable.has_method("interact")):return
	var int_area: Area3D = target_interactable.get_node("InteractionArea")
	if !int_area: return
	body.nav_agent.set_target_position(int_area.global_position)
	int_area.body_entered.connect(self_entered_interaction)

func enter():
	print("Curious")

func process(delta):
	if !target_interactable and !body.in_vent:
		target_interactable = body.get_director().get_vent_nearest_player().back()
	if body.in_vent and $Emerge.is_stopped():
		body.get_director().get_vent_nearest_player().front().exit(body,false)
	return EnemyState.State.None

func self_entered_interaction(area_body):
	if body != area_body: return
	print("Entered interaction area")
	target_interactable.interact(body,{"Noise":true})
	target_interactable = null



