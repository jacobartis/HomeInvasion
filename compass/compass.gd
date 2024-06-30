extends Node3D

@onready var enemy = get_tree().get_first_node_in_group("enemy")

var active: bool = false
var current_time: float = 0
var duration: float = 5

var charges: int = 3

func _process(delta):
	current_time = clamp(current_time-delta,0,INF)
	
	if !current_time:
		active = false
	
	if Input.is_action_just_pressed("player_use_item") and charges>0 and !current_time:
		active = true
		current_time = duration
		charges -= 1
	
	if !enemy:
		enemy = get_tree().get_first_node_in_group("enemy")
		return
	
	if !active:
		set_dial_color(Color(.1,.1,.1))
		return
	
	if enemy.in_vent:
		%DialHinge.rotation.y += delta*10
		if %DialHinge.rotation.y>=2*PI:
			%DialHinge.rotation.y = 0
		var rot = %DialHinge.rotation.y
		set_dial_color(Color(rot,rot,rot))
		return
	
	var dist = enemy.global_position.distance_to(global_position)/40.0
	$AngleGetter.look_at(enemy.global_position)
	%DialHinge.rotation.y = move_toward(%DialHinge.rotation.y,$AngleGetter.rotation.y,PI/16.0)
	set_dial_color(Color(1,dist,dist))

func recharge():
	charges = 3

func set_dial_color(color:Color):
	%Dial.mesh.material.albedo_color = color
