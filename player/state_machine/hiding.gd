extends PlayerState

func enter():
	print("hiding")

func physics_process(delta):
	body.stamina += delta*body.stamina_recovery
	body.set_velocity(Vector3.ZERO)
