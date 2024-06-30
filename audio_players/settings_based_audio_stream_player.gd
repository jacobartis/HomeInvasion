extends AudioStreamPlayer
class_name SettingsBasedAudioStreamPlayer

enum Types{
	SOUND,
	MUSIC
}

func _init(type:Types):
	if type == Types.SOUND:
		Settings.sound_vol_changed.connect(update_volume)
		update_volume(Settings.sound_volume)
	else:
		Settings.music_vol_changed.connect(update_volume)
		update_volume(Settings.music_volume)

func update_volume(val:float):
	volume_db = linear_to_db(val)
