extends StaticBody3D
class_name Door

signal state_changed()

var closed:bool = false

#Audio players
var close_audio:AudioStreamPlayer3D
var open_audio:AudioStreamPlayer3D

#Position of closed
var default_pos: Vector3 = Vector3.ZERO
#Offset for open
var move_pos: Vector3 = Vector3.ZERO

#Tween object for open and shut animation
var movement_tween: Tween

@onready var interaction_handler:InteractionHandler = InteractionHandler.new()

var interactable: bool = false

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
	if 'move_pos' in properties:
		move_pos = Vector3(properties['move_pos'])
	if 'interactable' in properties:
		interactable = !properties["interactable"].is_empty()

func _ready():
	#Saves current position as closed value
	default_pos = global_position
	#Updates the collision (on layer 2 for naviagtion reasons)
	collision_mask = 1
	collision_layer = 1
	add_to_group("door")
	if not closed:
		call_deferred("open")
	#Creates the open and close audio players
	close_audio = AudioStreamPlayer3D.new()
	open_audio = AudioStreamPlayer3D.new()
	close_audio.set_stream(preload("res://map_resources/door/door_toggle.mp3"))
	open_audio.set_stream(preload("res://map_resources/door/door_toggle.mp3"))
	add_child(close_audio)
	add_child(open_audio)
	close_audio.position = Vector3.ZERO
	open_audio.position = Vector3.ZERO
	open_audio.set_pitch_scale(.5)
	#Adds interaction handler
	add_child(interaction_handler)
	interaction_handler.interaction_finished.connect(interact)
	interaction_handler.enabled = interactable


func use(duration) -> void:
	toggle()
	await get_tree().create_timer(duration).timeout
	toggle()

func interact(body):
	toggle()

func toggle():
	if closed:
		open_audio.play()
		open()
	else:
		close_audio.play()
		close()

func open():
	if movement_tween:
		movement_tween.stop()
	#avoidance.set_avoidance_enabled(false)
	collision_layer = 2
	movement_tween = get_tree().create_tween()
	movement_tween.tween_property(self, "position", default_pos+move_pos, 1)
	movement_tween.play()
	closed = false
	await movement_tween.finished
	interaction_handler.interaction_msg = "close"
	state_changed.emit()

func close():
	if movement_tween:
		movement_tween.stop()
	collision_layer = 3
	movement_tween = get_tree().create_tween()
	movement_tween.tween_property(self, "position", default_pos, .25)
	movement_tween.play()
	closed = true
	await movement_tween.finished
	interaction_handler.interaction_msg = "open"
	state_changed.emit()
