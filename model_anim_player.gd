extends Node3D

@export var animation_name:String = "" :set=set_animation_name

func set_animation_name(new_anim):
	animation_name = ""
	if !$AnimationPlayer.has_animation(new_anim):
		push_error("Animation ",new_anim," isn't in animation player")
		return
	$AnimationPlayer.stop()
	$AnimationPlayer.play(new_anim)
