@tool
extends OmniLight3D


@export var properties: Dictionary :
	get:
		return properties
	set(new_properties):
		if(properties != new_properties):
			properties = new_properties
			update_properties()

func update_properties():
	if 'color' in properties:
		print(properties['color'])
		print(Color(properties['color']))
		if Color(properties['color']):
			light_color = Color(properties['color'])
	if 'range' in properties:
		omni_range = properties['range']
	if 'energy' in properties:
		light_energy = properties['energy']
