extends StaticBody3D

var on: bool = true
var running_audio = SettingsBasedAudioStreamPlayer3D.new(SettingsBasedAudioStreamPlayer3D.Types.SOUND)
var off_audio = SettingsBasedAudioStreamPlayer3D.new(SettingsBasedAudioStreamPlayer3D.Types.SOUND)

@export var properties: Dictionary :
	get:
		return properties
	set(new_properties):
		if(properties != new_properties):
			properties = new_properties
			update_properties()

func update_properties():
	pass

func _ready():
	running_audio.stream = preload("res://map_resources/generator/generator-large-01-31429.mp3")
	add_child(running_audio)
	running_audio.global_position = global_position
	running_audio.play()
	running_audio.autoplay = true
	off_audio.stream = preload("res://map_resources/generator/generator_off-93478.mp3")
	add_child(off_audio)
	off_audio.global_position = global_position

func interact(body,sprint=false):
	print("I have been interacted")
	if on:
		get_tree().call_group("powered","power_off")
		off_audio.play()
		running_audio.stop()
	else:
		get_tree().call_group("powered","power_on")
		running_audio.play()
	on = !on
