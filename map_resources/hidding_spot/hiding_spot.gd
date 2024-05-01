extends StaticBody3D

@onready var interaction_spot = $InteractionSpot

var entered: bool = false
var body: CharacterBody3D = null
var layer: int = 0
var mask: int = 0

func get_interaction_spot_pos():
	return interaction_spot.global_position

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
	body.collision_layer = 4
	body.collision_mask = 4
	body.global_position = self.global_position
	body.hiding_spot = self
	print("enter")

func exit():
	body.global_position = self.global_position+interaction_spot.position
	body.collision_layer = layer
	body.collision_mask = mask
	body.hiding_spot = null
	body = null
	print("exit")

func search():
	$AnimationPlayer.play("search")
	print("Searched")
	if body:
		exit()
