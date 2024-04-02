extends Node

@onready var search_state = $SearchState
@onready var hunt_state = $HuntState

@onready var aggro_timer = $AggroTimer

var body: CharacterBody3D

var nav_agent: NavigationAgent3D

func _ready():
	search_state.state_controller = self
	hunt_state.state_controller = self

func physics_process(delta):
	print(aggro_timer.time_left)
	if aggro_timer.time_left:
		hunt_state.physics_process(delta)
	else:
		search_state.physics_process(delta)
