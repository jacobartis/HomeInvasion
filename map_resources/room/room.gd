extends Area3D
class_name Room

var room_name: String = "default"

var player_entries: int = 0

@export var properties: Dictionary :
	get:
		return properties
	set(new_properties):
		if(properties != new_properties):
			properties = new_properties
			update_properties()

func update_properties():
	if 'roomname' in properties:
		room_name = properties['roomname']

func _ready():
	add_to_group("room")
	connect("body_entered",body_entered)
	collision_mask = 31
	collision_layer = 31

func get_hiding_spots():
	return get_overlapping_bodies().filter(
		func(body):
			return body.is_in_group("hiding_spot")
	)

func body_entered(body:Node3D):
	if !(body.is_in_group("enemy") or body.is_in_group("player")): return
	if body.is_in_group("player"):
		player_entries += 1
	body.set_room(self)
