extends Door

func _ready():
	add_to_group('powered')
	super()

#Only opens to power inputs
func use(duration) -> void:
	return

#Power only toggles state, polarity based on base closed value
func power_on():
	toggle()

func power_off():
	toggle()

func toggle():
	if closed:
		open_audio.play()
		open()
	else:
		close_audio.play()
		close()
