extends Node3D

@onready var ray_cast = $RayCast3D

var current_trap

func is_placing():
	return current_trap != null

func _process(delta):
	if !current_trap or !ray_cast.is_colliding(): return
	var collision_normal = ray_cast.get_collision_normal()
	current_trap.global_position = ray_cast.get_collision_point()+current_trap.place_offset*collision_normal
	if collision_normal.y>0:
		current_trap.current_surface = Trap.Surfaces.FLOOR
	elif collision_normal.y<0:
		current_trap.current_surface = Trap.Surfaces.CEILING
	else:
		current_trap.current_surface = Trap.Surfaces.WALL
	
	if current_trap.place_offset!=0 and collision_normal.y!=1:
		current_trap.look_at(ray_cast.get_collision_point())
	else:
		current_trap.global_rotation *= Vector3.ZERO

func start_placing(trap_data:TrapData):
	if !trap_data: return
	if current_trap:
		cancel_placement()
	current_trap = trap_data.get_instance()
	get_tree().get_first_node_in_group("world").add_child(current_trap)

func place_trap() -> bool:
	if !current_trap: return false
	if current_trap.can_place():
		current_trap.place()
		current_trap = null
		return true
	else:
		cancel_placement()
	return false

func cancel_placement():
	if !current_trap: return
	current_trap.queue_free()
	current_trap = null
