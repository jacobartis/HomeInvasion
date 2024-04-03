extends Node

@onready var cool_down = $CoolDown

var index = 3
var checks_required:int = 3

var state_controller:Node
var target_room:Room

var target_spot:Node3D
var spots_checked:int


func _ready():
	call_deferred("next_room")

func physics_process(delta):
	var body = state_controller.body
	var current_room = body.current_room
	if target_room == current_room:
		if !cool_down.time_left: 
			cool_down.start(3)
		return
	
	if !target_room:
		return
	
	body.look_at(state_controller.nav_agent.get_next_path_position())
	body.rotation.x = 0
	body.rotation.z = 0
	body.velocity += body.transform.basis * Vector3(0,0,-body.speed)

func next_spot():
	target_spot = target_room.get_hiding_spots().get_random()

func next_room():
	var rooms = get_tree().get_nodes_in_group("room")
	index += 1
	spots_checked = 0
	target_room = rooms[index%rooms.size()]
	if state_controller:
		state_controller.nav_agent.set_target_position(target_room.global_position)

func _on_cool_down_timeout():
	next_room()
