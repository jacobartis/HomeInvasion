extends CharacterBody3D

signal room_entered(room:Room)

@onready var nav_agent = $NavigationAgent3D
@onready var stun_timer = $StunTimer
@onready var state_controller = $StateController
@onready var animation_player = $AnimationPlayer
@onready var director = $Director

var room: Room :set=set_room, get=get_room

var stunned: bool = false
var speed: float = 5.0
const JUMP_VELOCITY = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func set_room(new_room:Room):
	room = new_room
	emit_signal("room_entered",room) 

func get_room():
	return room

func get_director():
	return director

func _ready():
	state_controller.init(self)
	director.init(self)

func _process(delta):
	state_controller.process(delta)

func _physics_process(delta):
	if stunned:
		return
	velocity.x = 0
	velocity.z = 0
	state_controller.physics_process(delta)
	if not is_on_floor():
		velocity.y -= gravity * delta
	if nav_agent.get_next_path_position() and not nav_agent.is_navigation_finished():
		look_at(nav_agent.get_next_path_position())
		rotation.x = 0
		rotation.z = 0
		velocity += transform.basis * Vector3(0,0,-speed)
	move_and_slide()

func noise(pos:Vector3):
	director.set_pos_of_interest(pos)

func stun(duration:float):
	stunned = true
	stun_timer.start(duration)

func _on_stun_timer_timeout():
	stunned = false

func _on_kill_body_entered(body):
	if !body.is_in_group("player"):return
	print("you lose")
	get_tree().quit()

func _on_door_area_body_entered(body):
	if body.is_in_group("door"):
		if body.closed:
			body.interact(self)
