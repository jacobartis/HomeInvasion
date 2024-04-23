extends StaticBody3D

@export_category("Loot")
@export var loot_type: CraftingInfo.Resources
@export var loot_quant: int

var looted: bool = false

func interact(interactor):
	if looted: return
	if !interactor.is_in_group("player"): return
	if loot_type == CraftingInfo.Resources.Currency:
		interactor.inventory_manager.currency += loot_quant
	else:
		interactor.crafting_manager.add_resource_quant(loot_type,loot_quant)
	looted = true
	$AnimationPlayer.play("open")
