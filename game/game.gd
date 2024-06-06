extends Node3D

@onready var prep_timer = $PrepTimer
@onready var round_timer = $RoundTimer

const ENEMY = preload("res://enemy/enemy.tscn")

func _ready():
	get_tree().get_first_node_in_group("timer_display").set_display(prep_timer,"Prep:")
	call_deferred("update_doors")

func update_doors():
	for door in get_tree().get_nodes_in_group("door"):
		door.connect("state_changed",$NavigationRegion3D.bake_navigation_mesh)

func spawn_enemy():
	var enemy = ENEMY.instantiate()
	var entry = get_tree().get_nodes_in_group("entry_point").pick_random()
	if !entry:
		return
	add_child(enemy)
	enemy.global_position = entry.global_position

func _process(delta):
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()

func _on_prep_timer_timeout():
	get_tree().get_first_node_in_group("timer_display").set_display(round_timer,"Survive!:")
	round_timer.start(99999)
	spawn_enemy()

func _on_round_timer_timeout():
	print("you win")
	get_tree().paused = true


func _on_navigation_region_3d_bake_finished():
	print("bake")
