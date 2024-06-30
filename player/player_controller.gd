extends CharacterBody3D

signal entered_room(new_room:Room)
signal entered_section(new_section:RoomSection)
signal stamina_update(new_val:float)
signal interaction_start(handler:InteractionHandler)

@export var interaction_handler: RayCast3D
@export var inventory_manager: Control
@export var trap_placer: Node3D

@onready var camera = $Camera3D
@onready var interact_handler = $Camera3D/InteractHandler
@onready var state_controller = $StateController


const SPEED = 5.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var stamina: float = 10 :set=set_stamina
var max_stamina:int = 10
var stamina_usage: float = 2
var stamina_recovery: float = 4
var sprint_cooldown:bool = false
var sprint_mult: float = 1.75

var room: Room :set=set_room, get=get_room
var section: RoomSection :set=set_section, get=get_section

var hiding_spot = null :set=set_hiding_spot, get=get_hiding_spot
var interaction_obj = null

func can_sprint():
	return stamina>0 and !sprint_cooldown

func set_stamina(quant):
	stamina = clamp(quant,0,max_stamina)
	stamina_update.emit(stamina)
	if stamina<= 0:
		sprint_cooldown = true
	if sprint_cooldown and stamina==max_stamina:
		sprint_cooldown = false

func set_hiding_spot(new_spot):
	hiding_spot = new_spot
	if !new_spot:
		state_controller.change_state(PlayerState.State.Idle)
	else:
		state_controller.change_state(PlayerState.State.Hiding)

func set_room(new_room):
	room = new_room
	emit_signal("entered_room",room)

func set_section(new_seciton:RoomSection):
	section = new_seciton
	emit_signal("section_entered",section) 

func get_hiding_spot():
	return hiding_spot

func get_room():
	return room

func get_section():
	return section

func interact_with(handler):
	interaction_start.emit(handler)
	state_controller.change_state(PlayerState.State.Interacting)
	handler.interact(self)

func _ready():
	interact_handler.body = self
	state_controller.init(self)
	#LevelInfo.menace_update.connect(menace_update)

func _process(delta):
	state_controller.process(delta)
	
	#Cancles placement if crafting open.
	if Input.is_action_pressed("player_inventory"): 
		if trap_placer.is_placing():
			trap_placer.cancel_placement()
		inventory_manager.show()
	else:
		inventory_manager.hide()

func _physics_process(delta):
	state_controller.physics_process(delta)
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y += 5
	move_and_slide()

func _input(event):
	state_controller.input(event)

func camera_movement(event:InputEventMouseMotion):
	if Input.is_action_pressed("player_inventory"):return
	if !event or Input.mouse_mode!=Input.MOUSE_MODE_CAPTURED: return
	rotate_y(-event.relative.x*Settings.get_sensitivity())
	camera.rotate_x(-event.relative.y*Settings.get_sensitivity())

#Selects current invent item and handles placement.
func inventory_and_placer_input(event:InputEvent):
	#Scrolls the selected invent item.
	if !trap_placer.is_placing():
		if event.is_action_pressed("next_item"):
			inventory_manager.next_item()
		elif event.is_action_pressed("prev_item"):
			inventory_manager.prev_item()
	#Starts and stops placing traps.
	if event.is_action_pressed("player_place_trap"):
		if !trap_placer.is_placing():
			trap_placer.start_placing(inventory_manager.get_selected_item())
		else:
			#Tries to place trap, removes item from invent if true.
			if trap_placer.place_trap(): inventory_manager.remove_selected()

func menace_update(val):
	print(val)
