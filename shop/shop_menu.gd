extends Control
class_name Shop

func _on_buy():
	get_tree().get_first_node_in_group("InventoryManager").add_item()

func _on_draw():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_hidden():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
