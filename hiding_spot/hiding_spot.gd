extends StaticBody3D

@export var exit_pos:Vector3 = Vector3(0,0,-2)

var entered: bool = false
var body: CharacterBody3D = null
var layer: int = 0
var mask: int = 0

func interact(interactor):
	if !interactor.is_in_group("player"):return
	if !body:
		body = interactor
		enter()
	else:
		exit()

func enter():
	layer = body.get_collision_layer()
	mask = body.get_collision_mask()
	body.collision_layer = 0
	body.collision_mask = 0
	body.global_position = self.global_position
	body.hiding_spot = self
	print("enter")

func exit():
	body.global_position = self.global_position+exit_pos
	body.collision_layer = layer
	body.collision_mask = mask
	body.hiding_spot = null
	body = null
	print("exit")

func search():
	if body:
		exit()
