extends Node

signal item_selected(item)
signal resources_updated(resources)

var _resource_quant: Dictionary = {
	CraftingInfo.Resources.Glass: 5,
	CraftingInfo.Resources.Cloth: 6,
	CraftingInfo.Resources.Metal: 6,
	CraftingInfo.Resources.Electonics: 0,
	CraftingInfo.Resources.Explosives: 0,
}

var bench: CraftingInfo.Benches = CraftingInfo.Benches.None 

var position: int = 0

func set_resource_quant(resource, quant:int):
	_resource_quant[resource] = quant
	emit_signal("resources_updated",_resource_quant)

func add_resource_quant(resource,quant):
	set_resource_quant(resource,_resource_quant[resource]+quant)

func get_resource_quant(resource:CraftingInfo.Resources):
	return _resource_quant[resource]

func get_recipes():
	return CraftingInfo.recipes

func get_selected_recipe():
	return get_recipes()[position]

func craft_selected():
	if temp_garbage(): return
	var result = get_recipes()[position].craft(_resource_quant,bench)
	emit_signal("resources_updated",_resource_quant)
	return result

func next_item():
	if temp_garbage(): return
	position = abs(position+1)%get_recipes().size()
	emit_signal("item_selected",get_recipes()[position].output_item)

func prev_item():
	if temp_garbage(): return
	position = abs(position-1)%get_recipes().size()
	emit_signal("item_selected",get_recipes()[position].output_item)

#TODO Make this not terrible
func temp_garbage():
	clamp(position,0,get_recipes().size()-1)
	return get_recipes().is_empty()
