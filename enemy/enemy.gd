extends CharacterBody3D

signal player_set(val)

@onready var nav_agent = $NavigationAgent3D
@onready var stun_timer = $StunTimer
@onready var player_ray = $PlayerRay
@onready var state_controller = $StateController

var player:Node3D:set=set_player
var player_seen: bool = false 

var pos_target:Vector3

var current_room: Room

var stunned: bool = false
var speed: float = 5.0
const JUMP_VELOCITY = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func set_player(val:Node3D):
	player = val
	emit_signal("player_set",val)
 
func _ready():
	state_controller.nav_agent = nav_agent
	state_controller.body = self

func _process(delta):
	if !player:
		player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if stunned:
		return
	velocity.x = 0
	velocity.z = 0
	state_controller.physics_process(delta)
	if not is_on_floor():
		velocity.y -= gravity * delta
	move_and_slide()

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
