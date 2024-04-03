extends Label

@onready var item_display = $ItemDisplay

func _on_inventory_manager_inventory_update(inventory):
	set_text(str(inventory))

func _on_inventory_manager_item_selected(item):
	item_display.set_text(str(item))
