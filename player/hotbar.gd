extends HBoxContainer

const HOTBAR_ELEMENT = preload("res://player/UI/hotbar_element.tscn")
var highlighted = 0

func _on_inventory_manager_inventory_update(inventory):
	for pos in inventory:
		get_children()[pos].set_item(inventory[pos])


func _on_inventory_manager_pos_selected(pos):
	highlighted = pos
	for child in get_children():
		child.highlighted = false
	get_children()[pos].highlighted = true
