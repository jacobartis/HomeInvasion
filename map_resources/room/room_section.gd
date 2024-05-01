extends Area3D
class_name RoomSection

@export var room_id: int = 0

var player_entries: int = 0
var last_checked: float

@export var properties: Dictionary :
	get:
		return properties
	set(new_properties):
		if(properties != new_properties):
			properties = new_properties
			update_properties()

func update_properties():
	if 'Room_id' in properties:
		room_id = properties['Room_id']

func _ready():
	collision_mask = 31
	collision_layer = 31
	LevelInfo.call_deferred("add_room_section",self)

func get_hiding_spots():
	return get_overlapping_bodies().filter(
		func(body):
			return body.is_in_group("hiding_spot")
	)
