@tool
extends StaticBody3D

var closed:bool = false

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
			close()
		else:
			open()

func _ready():
	add_to_group("door")

func interact(body):
	if closed:
		open()
	else:
		close()

func open():
	collision_layer = 2
	hide()
	closed = false

func close():
	collision_layer = 3
	show()
	closed = true
