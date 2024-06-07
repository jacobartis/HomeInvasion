extends Panel

var awaiting_key

func is_unique(event):
	return get_tree().get_nodes_in_group("input").filter(
		func (mapper):
			return mapper.get_key().is_match(event)
	).is_empty()

func _on_input_awaiting_input():
	awaiting_key = true
	$AwaitingInput.show()

func _on_input_recived_input():
	awaiting_key = false
	$AwaitingInput.hide()

func duplicate_popup():
	$Duplicate.popup_centered()

func close():
	if awaiting_key:
		get_tree().call_group("input","cancel")
		return
	hide()
