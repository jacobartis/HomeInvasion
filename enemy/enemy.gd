extends CharacterBody3D

signal room_entered(room:Room)
signal section_entered(section:Room)

@onready var nav_agent = $NavigationAgent3D
@onready var stun_timer = $StunTimer
@onready var action_controller = $ActionController
@onready var state_controller = $StateController
@onready var animation_player = $AnimationPlayer
@onready var director = $Director

@export var peaceful: bool = false

var room: Room :set=set_room, get=get_room
var section: RoomSection :set=set_section, get=get_section

const JUMP_VELOCITY = 4.5

var stunned: bool = false
var speed: float = 5.0

var stamina: float = 10: set=set_stamina
var max_stamina: float = 10
var stamina_regen: float = 1.5

var sprinting: bool = false :set=set_sprinting
var can_sprint:bool = true :set=set_can_sprint

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func set_room(new_room:Room):
	room = new_room
	emit_signal("room_entered",room) 

func set_section(new_seciton:RoomSection):
	section = new_seciton
	emit_signal("section_entered",section) 

func set_stamina(new_val:float):
	stamina = clamp(new_val,0,max_stamina)
	if stamina == 0:
		stun(2)
		can_sprint = false
	elif !can_sprint and stamina == max_stamina:
		can_sprint = true

func set_can_sprint(value:bool):
	can_sprint = value
	if !can_sprint:
		sprinting = false

func set_sprinting(value:bool):
	sprinting = value and can_sprint

func get_room():
	return room

func get_section():
	return section

func get_director():
	return director

func is_peaceful():
	return peaceful

func _ready():
	action_controller.init(self)
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
	action_controller.physics_process(delta)
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if nav_agent.get_next_path_position() and not nav_agent.is_navigation_finished():
		var current_speed = speed
		if sprinting:
			current_speed *= 1.5
			stamina -= delta*stamina_regen
			animation_player.play("walk")
		else:
			stamina += delta*stamina_regen
			animation_player.play("run")
		look_at(nav_agent.get_next_path_position())
		rotation.x = 0
		rotation.z = 0
		velocity += transform.basis * Vector3(0,0,-current_speed)
	
	move_and_slide()

func noise(pos:Vector3, vol:float=1):
	if global_position.distance_to(pos)/vol>10:
		return
	director.set_pos_of_interest(pos)

func stun(duration:float):
	stunned = true
	stun_timer.start(duration)

func _on_stun_timer_timeout():
	stunned = false

func _on_kill_body_entered(body):
	if !body.is_in_group("player") or peaceful:return
	print("you lose")
	get_tree().quit()

func _on_door_area_body_entered(body):
	if body.is_in_group("door"):
		if body.closed:
			body.interact(self)
