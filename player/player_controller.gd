extends CharacterBody3D

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

var crafting = false

var hiding_spot = null :set=set_hiding_spot

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

func _ready():
	interact_handler.body = self
	state_controller.init(self)

func _process(delta):
	state_controller.process(delta)

func _physics_process(delta):
	state_controller.physics_process(delta)
	move_and_slide()

func _input(event):
	state_controller.input(event)
	camera_movement(event as InputEventMouseMotion)

func camera_movement(event:InputEventMouseMotion):
	if !event or Input.mouse_mode!=Input.MOUSE_MODE_CAPTURED: return
	rotate_y(-event.relative.x*Settings.get_sensitivity())
	camera.rotate_x(-event.relative.y*Settings.get_sensitivity())
