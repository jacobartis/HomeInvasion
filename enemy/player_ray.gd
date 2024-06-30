extends RayCast3D

signal player_enter_view()
signal player_exit_view()

var player_in_view: set=set_player_in_view
var player: Node3D

func set_player(new_player):
	player = new_player

func set_player_in_view(val):
	if val == player_in_view:
		player_in_view = val
		return
	if val:
		player_enter_view.emit()
	else:
		player_exit_view.emit()
	
	player_in_view = val

func _process(delta):
	if !player: return
	look_at(player.global_position)
	rotation_degrees.x = clamp(rotation_degrees.x,-45,45)
	rotation_degrees.y = clamp(rotation_degrees.y,-45,45)
	if !is_colliding():return
	player_in_view = get_collider()==player

func _on_enemy_player_set(val):
	player = val
