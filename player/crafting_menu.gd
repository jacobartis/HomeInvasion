extends VBoxContainer


@onready var texture_rect = $TextureRect
@onready var current_recipe = $CurrentRecipe

func _on_crafting_manager_item_selected(item):
	texture_rect.set_texture(item.icon)
	current_recipe.set_text(item.title)
