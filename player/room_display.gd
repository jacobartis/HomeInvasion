extends Label



func _on_player_entered_room(new_room):
	set_text(str(LevelInfo.get_id(new_room)))
