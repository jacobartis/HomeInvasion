extends StaticBody3D

@onready var animation_player = $AnimationPlayer

var entered: bool = false
var body: CharacterBody3D = null

func interact(interactor):
	if !interactor.is_in_group("player"):return
	if !body:
		body = interactor
		enter()
	else:
		exit()

func enter():
	body.global_position = self.global_position
	body.global_position.y = -1000
	body.hiding_spot = self
	animation_player.play("enter")
	print("enter")

func exit():
	body.global_position = self.global_position-Vector3(0,0,-2)
	animation_player.play("exit")
	body.hiding_spot = null
	body = null
	print("exit")
