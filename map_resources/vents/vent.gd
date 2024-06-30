extends Node3D
class_name Vent

@export var properties: Dictionary :
	get:
		return properties
	set(new_properties):
		if(properties != new_properties):
			properties = new_properties
			update_properties()

func get_animation():
	return "search"

func update_properties():
	if 'angle' in properties:
		rotation.y = deg_to_rad(float(properties["angle"])-180)

func fake(noise:bool=true):
	if noise:
		$AnimationPlayer.play("open")
	else:
		$AnimationPlayer.play("open_silent")

func exit(body,noise:bool=true, delay:float=0):
	if noise:
		$AnimationPlayer.play("open")
	else:
		$AnimationPlayer.play("open_silent")
	await get_tree().create_timer(delay).timeout
	body.global_position = $InteractionArea.global_position
	body.in_vent = false

func enter(body,noise:bool=true, delay:float=0):
	if noise:
		$AnimationPlayer.play("open")
	else:
		$AnimationPlayer.play("open_silent")
	await get_tree().create_timer(delay).timeout
	body.global_position.y = -100
	body.in_vent = true

func move_sound():
	$MoveSound.play()

func interact(body,args:Dictionary={"Noise":true, "Delay":0}):
	if body.is_in_group("enemy"):
		enter(body,args["Noise"],args["Delay"])
