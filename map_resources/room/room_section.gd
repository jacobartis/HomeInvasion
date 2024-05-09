extends Area3D
class_name RoomSection

@export var room_id: int = 0
var doorway: bool = false

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
	if 'room_id' in properties:
		room_id = properties['room_id']
	if 'disabled' in properties:
		
		if properties['disabled']=="true": queue_free()
		elif properties['disabled']!="false" and properties['disabled']!="":
			push_warning("Disabled property not true or false, set to false by default")
	if 'doorway' in properties:
		if properties['doorway']=="true":
			doorway = true
		elif properties['doorway']!="false" and properties['doorway']!="":
			push_warning("Doorway property not true or false, set to false by default")

func _ready():
	collision_mask = 31
	collision_layer = 31
	LevelInfo.call_deferred("add_room_section",self)
	connect("body_entered",section_entered)

func get_hiding_spots(min_time:int=0):
	var hs = get_overlapping_bodies().filter(
		func(body):
			return body.is_in_group("hiding_spot")
	)
	var current = Time.get_ticks_msec()
	return hs.filter(
		func(spot):
			return current-spot.last_search>=min_time
	)

func section_entered(body:Node3D):
	if body.is_in_group("player"):
		player_entries += 1
	if body.is_in_group("enemy"):
		body.set_section(self)
