extends StaticBody3D

@export var properties: Dictionary :
	get:
		return properties
	set(new_properties):
		if(properties != new_properties):
			properties = new_properties
			update_properties()

func update_properties():
	if 'test' in properties:
		print(properties['test'])
