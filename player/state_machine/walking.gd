extends PlayerState


func process(delta):
	if movement_input() == Vector3.ZERO:
		return PlayerState.State.Idle
	if Input.is_action_pressed("player_sprint") and body.can_sprint():
		return PlayerState.State.Sprint
	return PlayerState.State.None

func movement_input():
	var input_dir =  Input.get_vector("player_left", "player_right", "player_forward", "player_backward")
	return (body.get_transform().basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

func physics_process(delta):
	body.stamina += delta*body.stamina_recovery
	movement(delta)

func movement(delta):
	var velocity = body.get_velocity()
	if not body.is_on_floor():
		velocity.y -= body.gravity * delta
	var direction = movement_input()
	velocity.x = direction.x * body.SPEED
	velocity.z = direction.z * body.SPEED
	body.set_velocity(velocity)
