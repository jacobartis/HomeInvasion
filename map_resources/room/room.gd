extends Area3D
class_name Room

var room_name: String = "default"

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

func body_entered(body:Node3D):
	if !body.is_in_group("enemy"): return
	body.current_room = self
