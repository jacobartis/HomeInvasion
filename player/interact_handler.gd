extends RayCast3D

@export var body:CharacterBody3D

func _process(delta):
	if !Input.is_action_just_pressed("player_interact"): return
	
	if body:
		if body.hiding_spot:
			body.hiding_spot.interact(body)
	
	if !is_colliding(): return
	if !get_collider().has_method("interact"): return
	get_collider().interact(body)
