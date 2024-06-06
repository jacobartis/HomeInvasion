extends CharacterBody3D

signal entered_room(new_room:Room)
signal entered_section(new_section:RoomSection)

#@export var crafting_menu: Control
@export var inventory_menu: Control

@export var interaction_handler: RayCast3D
@export var inventory_manager: Node
#@export var crafting_manager: Node
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

var crafting_open = false

var hiding_spot = null :set=set_hiding_spot, get=get_hiding_spot

func can_sprint():
	return stamina>0 and !sprint_cooldown

func set_stamina(quant):
	stamina = clamp(quant,0,max_stamina)
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

func _ready():
	interact_handler.body = self
	state_controller.init(self)
	#LevelInfo.menace_update.connect(menace_update)

func _process(delta):
	state_controller.process(delta)

func _physics_process(delta):
	state_controller.physics_process(delta)
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y += 5
	move_and_slide()

func _input(event):
	state_controller.input(event)
	camera_movement(event as InputEventMouseMotion)
	inventory_and_placer_input(event)

func camera_movement(event:InputEventMouseMotion):
	if !event or Input.mouse_mode!=Input.MOUSE_MODE_CAPTURED: return
	rotate_y(-event.relative.x*Settings.get_sensitivity())
	camera.rotate_x(-event.relative.y*Settings.get_sensitivity())

##handles crafting inputs
#func crafting_input(event:InputEvent):
	##toggles the crafting menu
	#if event.is_action_pressed("player_craft_menu"):
		#if crafting_open:
			#crafting_menu.hide()
			#inventory_menu.modulate.a = 1
			#crafting_open = false
		#else:
			#crafting_menu.show()
			#inventory_menu.modulate.a = .25
			#crafting_open = true
	#if !crafting_open: return
	##Moves current selection
	#if event.is_action_pressed("next_item"):
		#crafting_manager.next_item()
	#elif event.is_action_pressed("prev_item"):
		#crafting_manager.prev_item()
	##Crafts the item, adds it to the inventory
	#if event.is_action_pressed("player_craft"):
		#inventory_manager.add_item(crafting_manager.craft_selected())

#Selects current invent item and handles placement.
func inventory_and_placer_input(event:InputEvent):
	#Cancles placement if crafting open.
	if crafting_open: 
		if trap_placer.is_placing():
			trap_placer.cancel_placement()
		return
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
