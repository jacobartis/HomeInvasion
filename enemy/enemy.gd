extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var stun_timer = $StunTimer
@onready var player_ray = $PlayerRay

var target:CharacterBody3D

var pos_target:Vector3

var stunned: bool = false
var speed: float = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	if stunned:
		return
	
	velocity.x = 0
	velocity.z = 0
	if !target:
		find_target()
		return
	
	nav_agent.set_target_position(target.get_global_position())
	pos_target = nav_agent.get_next_path_position()
	
	look_at(pos_target)
	velocity = transform.basis * Vector3(0,0,-speed)
	if not is_on_floor():
		velocity.y -= gravity * delta
	move_and_slide()

func find_target():
	target = get_tree().get_first_node_in_group("player")
	return

func stun(duration:float):
	stunned = true
	stun_timer.start(duration)


func _on_stun_timer_timeout():
	stunned = false
