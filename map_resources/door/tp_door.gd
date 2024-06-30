extends StaticBody3D
class_name TPDoor

@onready var interaction_handler:InteractionHandler = InteractionHandler.new()

var id:String = "":
	set(new_id):
		remove_from_group(id)
		add_to_group(new_id)
		id = new_id

var exit_id:String = ""
var exit_offset: Vector3 = Vector3.FORWARD

@export var properties: Dictionary :
	get:
		return properties
	set(new_properties):
		if(properties != new_properties):
			properties = new_properties
			update_properties()

func update_properties():
	if "id" in properties:
		id = properties["id"]
	if "exit_id" in properties:
		exit_id = properties["exit_id"]
	if "exit_offset" in properties:
		exit_offset = properties["exit_offset"]

func get_exit_pos():
	return global_position + exit_offset*get_transform().basis

func _ready():
	add_to_group("tp_door")
	add_child(interaction_handler)
	interaction_handler.interaction_finished.connect(interact)
	interaction_handler.interaction_msg = "enter"

func interact(body):
	var tp_doors = get_tree().get_nodes_in_group("tp_door")
	tp_doors = tp_doors.filter(
		func(door):
			return door.is_in_group(exit_id) and door != self
	)
	if tp_doors.is_empty():
		push_warning(self,": No valid door of target id :",exit_id)
		return
	var exit_door = tp_doors.pick_random()
	body.global_position = exit_door.get_exit_pos()
