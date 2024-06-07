extends Node3D
class_name Vent

@export var properties: Dictionary :
	get:
		return properties
	set(new_properties):
		if(properties != new_properties):
			properties = new_properties
			update_properties()

func update_properties():
	if 'angle' in properties:
		rotation.y = deg_to_rad(float(properties["angle"])-180)

func exit(body,noise:bool):
	$AnimationPlayer.play("open")
	body.global_position = $InteractionArea.global_position
	body.in_vent = false

func enter(body,noise:bool):
	$AnimationPlayer.play("open")
	body.global_position.y = -100
	body.in_vent = true

func interact(body,args:Dictionary):
	if body.is_in_group("enemy"):
		enter(body,args["Noise"])
