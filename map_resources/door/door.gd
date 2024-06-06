extends StaticBody3D

signal state_changed()

var closed:bool = false
var close_audio:AudioStreamPlayer3D
var open_audio:AudioStreamPlayer3D
var avoidance: NavigationObstacle3D

@export var properties: Dictionary :
	get:
		return properties
	set(new_properties):
		if(properties != new_properties):
			properties = new_properties
			update_properties()

func update_properties():
	if 'closed' in properties:
		if properties["closed"]:
			closed = true
		else:
			closed = false

func _ready():
	collision_mask = 1
	collision_layer = 1
	add_to_group("door")
	if closed:
		call_deferred("close")
	else:
		call_deferred("open")
	close_audio = AudioStreamPlayer3D.new()
	open_audio = AudioStreamPlayer3D.new()
	close_audio.set_stream(preload("res://map_resources/door/door_toggle.mp3"))
	open_audio.set_stream(preload("res://map_resources/door/door_toggle.mp3"))
	add_child(close_audio)
	add_child(open_audio)
	close_audio.position = Vector3.ZERO
	open_audio.position = Vector3.ZERO
	open_audio.set_pitch_scale(.5)


func use(duration) -> void:
	toggle()
	await get_tree().create_timer(duration).timeout
	toggle()

func interact(body=null,rushed:bool=false):
	return
	#toggle()

func toggle():
	if closed:
		open_audio.play()
		open()
	else:
		close_audio.play()
		close()

func open():
	#avoidance.set_avoidance_enabled(false)
	collision_layer = 2
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", global_position+Vector3(0,5,0), 1)
	tween.play()
	closed = false
	await tween.finished
	state_changed.emit()

func close():
	collision_layer = 3
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", global_position-Vector3(0,5,0), .25)
	tween.play()
	closed = true
	await tween.finished
	state_changed.emit()
