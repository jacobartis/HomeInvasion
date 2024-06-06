extends StaticBody3D

signal searched()

@onready var interaction_spot = $InteractionSpot

var entered: bool = false
var body: CharacterBody3D = null
var layer: int = 0
var mask: int = 0
var last_search: int = 0

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


func get_interaction_spot_pos():
	return interaction_spot.global_position

func interact(interactor,rushed:bool=false):
	if !interactor.is_in_group("player"):return
	if !body:
		body = interactor
		enter(rushed)
	else:
		exit(rushed)

func enter(rushed:bool=false):
	if rushed:
		$AnimationPlayer.stop()
		$AnimationPlayer.play("search")
		get_tree().call_group("enemy","noise",global_position,2)
	else:
		get_tree().call_group("enemy","noise",global_position,.75)
	layer = body.get_collision_layer()
	mask = body.get_collision_mask()
	body.collision_layer = 4
	body.collision_mask = 4
	body.global_position = $CameraPos.global_position
	body.hiding_spot = self
	print("enter")

func exit(rushed:bool=false):
	if rushed:
		$AnimationPlayer.stop()
		$AnimationPlayer.play("search")
		get_tree().call_group("enemy","noise",global_position,2)
	else:
		get_tree().call_group("enemy","noise",global_position,.75)
	body.global_position = interaction_spot.global_position
	body.collision_layer = layer
	body.collision_mask = mask
	body.hiding_spot = null
	body = null
	print("exit")

func search():
	last_search = Time.get_ticks_msec()
	emit_signal("searched")
	$AnimationPlayer.stop()
	$AnimationPlayer.play("search")
	if body:
		exit()
