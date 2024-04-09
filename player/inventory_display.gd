extends Label

@onready var item_display = $ItemDisplay

func _on_inventory_manager_inventory_update(inventory):
	var list = ""
	for key in inventory:
		list += key.title+" "+str(inventory[key])+", "
	set_text(list)

func _on_inventory_manager_item_selected(item:TrapData):
	if !item: 
		item_display.set_text("None") 
		return
	item_display.set_text(str(item.title))
