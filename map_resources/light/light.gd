@tool
extends OmniLight3D

var energy = light_energy 

var inverted = false
var power_resistant = false

@export var properties: Dictionary :
	get:
		return properties
	set(new_properties):
		if(properties != new_properties):
			properties = new_properties
			update_properties()

func update_properties():
	if 'color' in properties:
		if Color(properties['color']):
			light_color = Color(properties['color'])
	if 'attenuation' in properties:
		omni_attenuation = properties['attenuation']
	if 'range' in properties:
		omni_range = properties['range']
	if 'size' in properties:
		light_size = properties['size']
	if 'specular' in properties:
		light_specular = properties['specular']
	if 'energy' in properties:
		light_energy = properties['energy']
		energy = properties['energy']
	if 'inverted_power' in properties:
		inverted = properties['inverted_power']
		power_update(true)
	if 'power_resistant' in properties:
		power_resistant = properties['power_resistant']

func _ready():
	add_to_group("powered")

func power_off():
	if power_resistant=='true':return
	power_update(false)

func power_on():
	if power_resistant=='true':return
	power_update(true)

func power_update(on:bool):
	if inverted:
		on = !on 
	
	if on:
		light_energy = energy
	else:
		light_energy = 0
