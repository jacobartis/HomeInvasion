extends Label

func _on_interact_handler_new_interact_obj(handler:InteractionHandler):
	if !handler: 
		set_text("")
		return
	var interact_msg = handler.interaction_msg
	
	if !interact_msg: interact_msg = "interact"
	var button
	if !InputMap.action_get_events("player_interact"):
		button = "none"
	else:
		button = InputMap.action_get_events("player_interact").front().as_text().trim_suffix(" (Physical)")
	set_text("Press {button} to {msg}".format({"button":button,"msg":interact_msg}))
