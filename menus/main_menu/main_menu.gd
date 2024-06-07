extends Control


func _on_play_pressed():
	get_tree().change_scene_to_packed(preload("res://world.tscn"))

func _on_settings_pressed():
	Settings.show()

func _on_quit_pressed():
	get_tree().quit()


func _on_funny_pressed():
	$AudioStreamPlayer.play()
