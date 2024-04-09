extends Resource
class_name TrapData

@export var title: String = "Placeholder"
@export var trap_scene: PackedScene
@export var icon: Texture2D

func get_instance():
	return trap_scene.instantiate()
