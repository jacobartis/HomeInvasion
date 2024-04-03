extends Control
class_name Shop

const TRAP = preload("res://traps/test_trap/trap.tscn")
const TRAP2 = preload("res://traps/test_trap/trap2.tscn")

func _on_buy():
	get_tree().get_first_node_in_group("InventoryManager").add_item(TRAP)

func _on_buy2():
	get_tree().get_first_node_in_group("InventoryManager").add_item(TRAP2)

func _on_draw():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_hidden():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
