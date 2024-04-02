extends Camera3D

@export var follower_cam: Camera3D


func _physics_process(delta):
	global_transform = follower_cam.global_transform
