extends Node
signal toggled_pause(val)

var sensitivity: float = .004: get=get_sensitivity
var paused: bool = false: set = set_paused

func get_sensitivity():
	return sensitivity

func set_paused(val):
	paused = val
	toggled_pause.emit(val)

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		set_paused(Input.mouse_mode==Input.MOUSE_MODE_CAPTURED)
		if Input.mouse_mode==Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode=Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
