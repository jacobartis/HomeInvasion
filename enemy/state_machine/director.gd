extends Node

signal player_found(new_player)
signal new_pos_of_interest(new_pos)

var player : set=set_player
var body
var pos_of_interest: Vector3 :set=set_pos_of_interest, get=get_pos_of_interest

func set_player(new_player):
	player = new_player
	emit_signal("player_found",player)

func set_pos_of_interest(new_pos):
	if body.is_deaf(): return
	pos_of_interest = new_pos
	emit_signal("new_pos_of_interest", new_pos)

func _ready():
	player = get_tree().get_first_node_in_group("player")

func init(new_body):
	body = new_body

func get_pos_of_interest():
	return pos_of_interest

func get_close_rooms(inner_radius:float,outer_radius:float) -> Array:
	if inner_radius>=outer_radius:
		push_warning("inner radius is bigger than outer radius: ",inner_radius,",",outer_radius)
	return LevelInfo.get_rooms_array().filter(
		func(room):
			var distance = player.global_position.distance_to(
				room.get_sections()[0].global_position)
			return distance<=outer_radius and distance>=inner_radius
	)

func get_common_rooms() -> Array:
	var rooms = LevelInfo.get_rooms_array()
	rooms.sort_custom(
		func(a,b):
			return a.player_entries>b.player_entries
	)
	return rooms

func get_player_room():
	return player.get_room()

func get_player_section():
	return player.get_section()

func get_player_pos():
	return player.get_global_position()

func get_player_hiding_spot():
	return player.get_hiding_spot()

func get_random_behaviour():
	var rand = randi()%3
	rand = 0
	if rand == 0:
		return EnemyState.State.Aggressive
	elif rand == 1:
		return EnemyState.State.Curious
	return EnemyState.State.Tactical
