extends AudioStreamPlayer3D
class_name SettingsBasedAudioStreamPlayer3D

enum Types{
	SOUND,
	MUSIC
}

@export var type:Types = Types.SOUND

var base_vol: float

@export var properties: Dictionary :
	get:
		return properties
	set(new_properties):
		if(properties != new_properties):
			properties = new_properties
			update_properties()

func update_properties():
	if "vol" in properties:
		base_vol = properties["vol"]
	if "type" in properties:
		type = properties["type"]
		if !type in Types:
			type = Types.SOUND
	if "sound_path" in properties:
		stream = load(properties["sound_path"])
	if "autoplay" in properties:
		autoplay = properties["autoplay"]

func use(duration):
	playing = !playing

func _init(init_type:Types=type):
	base_vol = volume_db
	type = init_type
	if type == Types.SOUND:
		Settings.sound_vol_changed.connect(update_volume)
		update_volume(Settings.sound_volume)
	else:
		Settings.music_vol_changed.connect(update_volume)
		update_volume(Settings.music_volume)

func update_volume(val:float):
	volume_db = base_vol+linear_to_db(val)
