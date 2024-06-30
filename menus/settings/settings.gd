extends CanvasLayer

signal toggled_pause(val)
signal music_vol_changed(val)
signal sound_vol_changed(val)

var sensitivity: float = .004: get=get_sensitivity

var music_volume: float = 1:
	set(val):
		music_volume = val
		music_vol_changed.emit(val)

var sound_volume: float = 1:
	set(val):
		sound_volume = val
		sound_vol_changed.emit(val)

var paused: bool = false: set = set_paused

func get_sensitivity():
	return sensitivity

func set_paused(val):
	paused = val
	toggled_pause.emit(val)
	visible = val
	if get_tree().get_nodes_in_group("world"):
		get_tree().paused = val

func _ready():
	%DebugButton.visible = OS.is_debug_build()

func _process(delta):
	%MenuButton.visible = get_tree().get_nodes_in_group("main_menu").is_empty()
	if Input.is_action_just_pressed("ui_cancel"):
		if !paused:
			open()
		#Unpauses the game if other menus are closed
		elif get_tree().get_nodes_in_group("sub_menu").any(func(menu): return menu.visible):
			get_tree().call_group("sub_menu","close")
		else:
			close()

func _on_music_slider_value_changed(value):
	music_volume = value

func _on_sound_slider_value_changed(value):
	sound_volume = value

func _on_close_pressed():
	close()

func close():
	if get_tree().get_nodes_in_group("world"):
		Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
	set_paused(false)
	hide()

func open():
	Input.mouse_mode=Input.MOUSE_MODE_VISIBLE
	show()
	set_paused(true)

func _on_quit_pressed():
	get_tree().quit()

func _on_menu_pressed():
	set_paused(false)
	hide()
	get_tree().change_scene_to_file("res://menus/main_menu/main_menu.tscn")

