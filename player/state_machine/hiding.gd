extends PlayerState

func enter():
	print("hiding")

func input(event):
	body.camera_movement(event as InputEventMouseMotion)

func physics_process(delta):
	body.stamina += delta*body.stamina_recovery
	body.set_velocity(Vector3.ZERO)
