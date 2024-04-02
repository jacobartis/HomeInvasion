extends RayCast3D

signal player_seen()

var player: Node3D

func _process(delta):
	if !player: return
	
	look_at(player.global_position)
	rotation_degrees.x = clamp(rotation_degrees.x,-45,45)
	rotation_degrees.y = clamp(rotation_degrees.y,-45,45)
	if !is_colliding():return
	if get_collider()==player: emit_signal("player_seen")
	


func _on_enemy_player_set(val):
	player = val
