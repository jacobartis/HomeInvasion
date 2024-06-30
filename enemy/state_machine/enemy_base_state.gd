extends Node
class_name EnemyState

enum State{
	None,
	Idle,
	Absent,
	Observation,
	Confusion,
	Curious,
	Chase,
	Intimidation,
	Ambush,
	Prowling,
}

var body

var interact_target: Node3D : 
	set(new):
		if interact_target:
			interact_target.get_node("InteractionArea").body_entered.disconnect(self_entered_interaction)
		
		interact_target = new
		if !interact_target: return
		
		if not (interact_target.has_node("InteractionArea") and interact_target.has_method("interact")):return
		var int_area: Area3D = interact_target.get_node("InteractionArea")
		if !int_area: return
		if body in int_area.get_overlapping_bodies():
			self_entered_interaction(int_area)
			return
		body.nav_agent.set_target_position(int_area.global_position)
		int_area.body_entered.connect(self_entered_interaction)

func self_entered_interaction(area_body):
	if body != area_body: return
	print("Entered interaction area")
	var anim = interact_target.interact(body,{"Noise":true, "Delay":0})
	if anim:
		body.animation_player.play(anim)
		await body.animation_player.animation_finished
	interact_target = null

func init(new_body):
	body = new_body

func enter():
	pass

func exit():
	interact_target = null

func process(delta) -> State:
	return State.None

func physics_process(delta):
	pass

func input(event):
	pass

