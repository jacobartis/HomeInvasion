extends StaticBody3D

@export_category("Loot")
@export var loot_type: CraftingInfo.Resources
@export var loot_quant: int

@export var properties: Dictionary :
	get:
		return properties
	set(new_properties):
		if(properties != new_properties):
			properties = new_properties
			update_properties()

func update_properties():
	if 'angle' in properties:
		rotation.y = deg_to_rad(float(properties["angle"])-180)

var looted: bool = false


func _ready():
	loot_type = randi()%6
	loot_quant = randi_range(1,5)

func interact(interactor,rushed:bool=false):
	if looted: return
	if !interactor.is_in_group("player"): return
	if loot_type == CraftingInfo.Resources.Currency:
		interactor.inventory_manager.currency += loot_quant
	else:
		interactor.crafting_manager.add_resource_quant(loot_type,loot_quant)
	looted = true
	$AnimationPlayer.play("open")
