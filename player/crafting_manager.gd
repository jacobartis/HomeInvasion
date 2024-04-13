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

var current_recipes: Array[CraftingRecipe] = [preload("res://crafting/recipes/marbles.tres"),
preload("res://crafting/recipes/marbles2.tres")]

var position: int = 0

func set_resource_quant(resource, quant:int):
	_resource_quant[resource] = quant
	emit_signal("resources_updated",_resource_quant)

func get_resource_quant(resource:CraftingInfo.Resources):
	return _resource_quant[resource]

func craft_selected():
	var result = current_recipes[position].craft(_resource_quant,bench)
	emit_signal("resources_updated",_resource_quant)
	return result

func next_item():
	if current_recipes.is_empty():return
	position = abs(position+1)%current_recipes.size()
	emit_signal("item_selected",current_recipes[position])

func prev_item():
	if current_recipes.is_empty():return
	position = abs(position-1)%current_recipes.size()
	emit_signal("item_selected",current_recipes[position])
