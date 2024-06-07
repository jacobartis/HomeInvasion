extends Panel

@onready var environment = preload("res://game/environment.tres")
@onready var old_env = environment.duplicate()

func _ready():
	visibility_changed.connect(update_values)

func close():
	hide()

func update_values():
	$Control/ScrollContainer/VBoxContainer/Sky/Color/SkyColor.color = environment.background_color
	$Control/ScrollContainer/VBoxContainer/AmbientLight/Color/LightColor.color = environment.ambient_light_color
	$Control/ScrollContainer/VBoxContainer/AmbientLight/Energy/LightEnergy.value = environment.ambient_light_energy
	$Control/ScrollContainer/VBoxContainer/Fog/Enabled/FogColor.button_pressed = environment.fog_enabled
	$Control/ScrollContainer/VBoxContainer/Fog/Color/FogColor.color =environment.fog_light_color
	$Control/ScrollContainer/VBoxContainer/Fog/Energy/FogEnergy.value = environment.fog_light_energy
	$Control/ScrollContainer/VBoxContainer/Fog/Dencity/FogDensity.value = environment.fog_density

func _on_sky_color_color_changed(color):
	environment.background_color = color

func _on_light_color_color_changed(color):
	environment.ambient_light_color = color

func _on_light_energy_value_changed(value):
	environment.ambient_light_energy = value

func _on_fog_color_color_changed(color):
	environment.fog_light_color = color

func _on_fog_energy_value_changed(value):
	environment.fog_light_energy = value

func _on_fog_density_value_changed(value):
	environment.fog_density = value

func _on_fog_color_toggled(toggled_on):
	environment.fog_enabled = toggled_on

func _on_save_button_pressed():
	ResourceSaver.save(environment,"res://game/environment.tres")
	old_env = environment.duplicate()

func _on_reset_button_pressed():
	environment.background_color = old_env.background_color
	environment.ambient_light_color = old_env.ambient_light_color
	environment.ambient_light_energy = old_env.ambient_light_energy
	environment.fog_light_color = old_env.fog_light_color
	environment.fog_light_energy = old_env.fog_light_energy
	environment.fog_density = old_env.fog_density
	environment.fog_enabled = old_env.fog_enabled
	update_values()
