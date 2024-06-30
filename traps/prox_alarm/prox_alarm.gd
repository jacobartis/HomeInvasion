extends Trap

@export var detection_area:Area3D
@export var duration: float = 3
var remaining: float = 0

func _process(delta):
	super(delta)
	if !placed:
		return
	
	if remaining:
		get_tree().call_group("enemy","noise",global_position,3)
	
	if remaining and !$AlarmNoise.playing:
		$AlarmNoise.playing = true
		$Model/OmniLight3D.light_color = Color.RED
	elif !remaining:
		$AlarmNoise.playing = false
		$Model/OmniLight3D.light_color = Color.GREEN
	remaining = clamp(remaining-delta,0,INF)

func _physics_process(delta):
	if !placed:
		return
	if detection_area.get_overlapping_bodies().any(valid_body_in_sight):
		remaining = duration

func valid_body_in_sight(body):
	if !body.is_in_group("player") and !body.is_in_group("enemy"): return false
	var space = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(global_position,body.global_position)
	var result = space.intersect_ray(query)
	if !result: return false
	return result.collider == body
