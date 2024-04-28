extends Node

var player

func _ready():
	player = get_tree().get_first_node_in_group("player")

func get_close_rooms(outer_radius:float,inner_radius:float) -> Array:
	return get_tree().get_nodes_in_group("room").filter(
		func(room):
			var distance = player.global_position.distance_to(room.global_position)
			return distance<=outer_radius and distance>=inner_radius
	)

func get_common_rooms() -> Array:
	var rooms = get_tree().get_nodes_in_group("room")
	rooms.sort_custom(
		func(a,b):
			return a.player_entries>b.player_entries
	)
	return rooms

func get_player_room():
	return player.get_room()

func get_player_pos():
	return player.global_position()

func get_player_hiding_spot():
	return player.get_hiding_spot()

func get_random_behaviour():
	var rand = randi()%3
	if rand == 0:
		return EnemyState.State.Aggressive
	elif rand == 1:
		return EnemyState.State.Curious
	return EnemyState.State.Tactical
