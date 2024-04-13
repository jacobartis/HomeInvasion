extends Label


func _on_crafting_manager_resources_updated(resources):
	var list = ""
	for key in resources:
		list += str(CraftingInfo.RESOURCE_NAMES[key])+" "+str(resources[key])+"\n"
	set_text(list)


func _on_crafting_manager_item_selected(item):
	set_text(item.title)
