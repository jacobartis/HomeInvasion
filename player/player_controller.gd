extends CharacterBody3D

@onready var camera = $Camera3D
@onready var interact_handler = $Camera3D/InteractHandler


const SPEED = 5.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var stamina: float = 20
var max_stamina:int = 20
var sprint_cooldown:bool = false

var hiding_spot = null

func _ready():
	interact_handler.body = self

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	var input_dir = Input.get_vector("player_left", "player_right", "player_forward", "player_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var speed = SPEED
	
	if Input.is_action_pressed("player_sprint") and stamina>0 and !sprint_cooldown:
		stamina -= delta*5
		speed *= 1.75
	else:
		stamina = clamp(stamina+delta*100,0,max_stamina)
	if stamina<= 0:
		sprint_cooldown = true
	if sprint_cooldown and stamina==max_stamina:
		sprint_cooldown = false
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	if hiding_spot:
		velocity = Vector3.ZERO
	move_and_slide()

func _input(event):
	camera_movement(event as InputEventMouseMotion)

func camera_movement(event:InputEventMouseMotion):
	if !event or Input.mouse_mode!=Input.MOUSE_MODE_CAPTURED: return
	rotate_y(-event.relative.x*Settings.get_sensitivity())
	camera.rotate_x(-event.relative.y*Settings.get_sensitivity())
