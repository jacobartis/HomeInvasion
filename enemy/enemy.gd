extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D

var target:CharacterBody3D

var pos_target:Vector3

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	velocity.x = 0
	velocity.z = 0
	if !target:
		find_target()
		return
	
	nav_agent.set_target_position(target.get_global_position())
	pos_target = nav_agent.get_next_path_position()
	
	look_at(pos_target)
	velocity = transform.basis * Vector3(0,0,-SPEED)
	if not is_on_floor():
		velocity.y -= gravity * delta
	move_and_slide()

func find_target():
	target = get_tree().get_first_node_in_group("player")
	return
