extends Node3D

@onready var ray_cast = $RayCast3D
@onready var inventory_manager = $InventoryManager


var placing: bool = false
var current_trap


func _process(delta):
	if !placing:
		return
	if !ray_cast.is_colliding():
		return
	current_trap.global_position = ray_cast.get_collision_point()+current_trap.place_offset

func _input(event):
	if event.is_action_pressed("next_item") and !placing:
		inventory_manager.next_item()
	if event.is_action_pressed("prev_item") and !placing:
		inventory_manager.prev_item()
	
	if !event.is_action_pressed("player_place_trap"):
		return
	
	if placing:
		current_trap.place()
		current_trap = null
		placing = false
		inventory_manager.remove_selected()
	else:
		if !inventory_manager.get_selected_item():return
		current_trap = inventory_manager.get_selected_item().get_instance()
		get_tree().get_first_node_in_group("world").add_child(current_trap)
		placing = true
