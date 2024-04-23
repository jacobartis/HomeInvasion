extends Resource
class_name CraftingRecipe


@export_category("Requirements")
@export var bench_requirement: CraftingInfo.Benches
@export_category("Resource costs")
@export var glass: int
@export var cloth: int
@export var metal: int
@export var electronics: int
@export var explosives: int
@export var craft_time: float
@export_category("Crafting Output")
@export var output_item:TrapData

#None of this is pretty :(
#TODO Clean both these up maybe?
func can_craft(crafting_resources:Dictionary,bench:CraftingInfo.Benches):
	if bench != bench_requirement:
		return false
	if crafting_resources[CraftingInfo.Resources.Glass]<glass:
		return false
	if crafting_resources[CraftingInfo.Resources.Cloth]<cloth:
		return false
	if crafting_resources[CraftingInfo.Resources.Metal]<metal:
		return false
	if crafting_resources[CraftingInfo.Resources.Electonics]<electronics:
		return false
	if crafting_resources[CraftingInfo.Resources.Explosives]<explosives:
		return false
	return true

func craft(crafting_resources:Dictionary,bench:CraftingInfo.Benches) -> TrapData:
	if !can_craft(crafting_resources,bench): return null
	crafting_resources[CraftingInfo.Resources.Glass] -= glass
	crafting_resources[CraftingInfo.Resources.Cloth] -= cloth
	crafting_resources[CraftingInfo.Resources.Metal] -= metal
	crafting_resources[CraftingInfo.Resources.Electonics] -= electronics
	crafting_resources[CraftingInfo.Resources.Explosives] -= explosives
	return output_item
