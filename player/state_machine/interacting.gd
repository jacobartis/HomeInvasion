extends PlayerState

var current_handler:InteractionHandler = null:
	set(new_handler):
		if new_handler==current_handler:return
		if current_handler:
			current_handler.disconnect("interaction_end",end_interaction)
		current_handler = new_handler
		if !current_handler:return
		current_handler.connect("interaction_end",end_interaction)

func end_interaction(int_body):
	current_handler = null

func process(delta):
	if !current_handler:
		return PlayerState.State.Idle
	return PlayerState.State.None

func physics_process(delta):
	body.velocity *= Vector3(0,1,0)
	if not body.is_on_floor():
		body.velocity.y -= body.gravity * delta

func _on_player_interaction_start(handler):
	current_handler = handler
