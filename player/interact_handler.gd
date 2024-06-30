extends RayCast3D

signal new_interact_obj(obj)

@export var body:CharacterBody3D

var current_obj:InteractionHandler = null:
	set(new_obj):
		new_obj = new_obj as InteractionHandler
		new_interact_obj.emit(new_obj)
		current_obj = new_obj 

func _process(delta):
	if !get_collider():
		current_obj = null
	elif "interaction_handler" in get_collider():
		if get_collider().interaction_handler.enabled:
			current_obj = get_collider().interaction_handler
	else:
		current_obj = null

func _input(event):
	if !event.is_action_pressed("player_interact"): return
	if !body: return
	
	if body.hiding_spot:
		body.hiding_spot.interact(body)
		return
	
	if !current_obj: return
	body.interact_with(current_obj)
