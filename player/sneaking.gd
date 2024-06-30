extends PlayerState


func enter():
	body.get_node("SneakAudio").play()

func exit():
	body.get_node("SneakAudio").stop()

func input(event):
	body.camera_movement(event as InputEventMouseMotion)
	body.inventory_and_placer_input(event)

func process(delta):
	if movement_input() == Vector3.ZERO:
		return PlayerState.State.Idle
	if !Input.is_action_pressed("player_sneak"):
		return PlayerState.State.Walking
	if Input.is_action_pressed("player_sprint") and body.can_sprint():
		return PlayerState.State.Sprint
	get_tree().call_group("enemy","noise",body.global_position,.1)
	return PlayerState.State.None

func movement_input():
	var input_dir =  Input.get_vector("player_left", "player_right", "player_forward", "player_backward")
	return (body.get_transform().basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

func physics_process(delta):
	body.stamina += delta*body.stamina_recovery*1.5
	movement(delta)

func movement(delta):
	var velocity = body.get_velocity()
	if not body.is_on_floor():
		velocity.y -= body.gravity * delta
	var direction = movement_input()
	velocity.x = direction.x * body.SPEED/2
	velocity.z = direction.z * body.SPEED/2
	body.set_velocity(velocity)
