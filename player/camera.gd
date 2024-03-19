extends Camera3D

@onready var camera_3d = $SubViewportContainer/SubViewport/Camera3D


func _physics_process(delta):
	camera_3d.global_transform = global_transform
