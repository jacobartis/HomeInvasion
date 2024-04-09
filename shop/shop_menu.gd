extends Control
class_name Shop

const TEST_TRAP = preload("res://traps/test_trap/test_trap.tres")
const TEST_TRAP_2 = preload("res://traps/test_trap/test_trap2.tres")

func _on_buy():
	get_tree().get_first_node_in_group("InventoryManager").add_item(TEST_TRAP)

func _on_buy2():
	get_tree().get_first_node_in_group("InventoryManager").add_item(TEST_TRAP_2)

func _on_draw():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_hidden():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
