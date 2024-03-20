extends Node3D

@onready var ray_cast = $RayCast3D

const TRAP = preload("res://trap/trap.tscn")

var placing: bool = false
var current_trap


func _process(delta):
	if !placing:
		return
	if !ray_cast.is_colliding():
		return
	current_trap.global_position = ray_cast.get_collision_point()+current_trap.place_offset

func _input(event):
	if !event.is_action_pressed("player_place_trap"):
		return
	if placing:
		current_trap.place()
		current_trap = null
		placing = false
	else:
		current_trap = TRAP.instantiate()
		get_tree().get_first_node_in_group("world").add_child(current_trap)
		placing = true
