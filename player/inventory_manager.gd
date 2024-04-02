extends Node

const TRAP = preload("res://traps/test_trap/trap.tscn")

var items: int = 1

func get_selected_item():
	if items<=0:return null
	items -= 1
	return TRAP.instantiate()

func add_item(item:PackedScene=null):
	items += 1
