extends Sprite3D


func _ready():
	hide()

func enable(duration):
	var player = get_tree().get_first_node_in_group("player")
	if player.global_position.distance_to(global_position)>30: return
	$Timer.start(duration)
	$AudioStreamPlayer3D.play()
	show()

func _on_timer_timeout():
	hide()
