extends Node

enum Benches{
	None,
	Crafting_Bench
}

enum Resources {
	Glass,
	Cloth,
	Metal,
	Electonics,
	Explosives
}

const RESOURCE_NAMES:Dictionary ={
	Resources.Glass: "Glass",
	Resources.Cloth: "Cloth",
	Resources.Metal: "Metal",
	Resources.Electonics: "Electonics",
	Resources.Explosives: "Explosives",
} 

var recipes: Array

func _ready():
	load_recipes()

func load_recipes():
	recipes = load_files("res://crafting/recipes/","tres")
	for recipe in recipes:
		if !(recipe is CraftingRecipe):
			recipes.erase(recipe)

func load_files(path:String,type:String):
	var resources = []
	var folder = DirAccess.open(path)
	for file_path in folder.get_files():
		if !type in file_path:
			continue
		resources.append(load(path+file_path))
	return resources
