extends PlayerState

func input(event):
	body.camera_movement(event as InputEventMouseMotion)
	body.inventory_and_placer_input(event)

func process(delta):
	if is_direction_pressed():
		return PlayerState.State.Walking
	return PlayerState.State.None

func is_direction_pressed() -> bool:
	return Input.get_vector("player_left", "player_right", "player_forward", "player_backward") != Vector2.ZERO

func physics_process(delta):
	body.stamina += delta*body.stamina_recovery*2
	movement(delta)

func movement(delta):
	var velocity  = body.velocity
	if not body.is_on_floor():
		velocity.y -= body.gravity * delta
	velocity.x = move_toward(velocity.x, 0, body.SPEED)
	velocity.z = move_toward(velocity.z, 0, body.SPEED)
	body.set_velocity(velocity)
