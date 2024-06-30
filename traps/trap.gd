extends Node3D
class_name Trap

signal just_placed()

enum Surfaces{
	WALL,
	FLOOR,
	CEILING,
	ALL
}

@export_category("Nodes")
@export var placement_guide:MeshInstance3D
@export var place_area:Area3D
@export var model:MeshInstance3D
@export_category("Info")
@export var place_offset: float = .2
@export var valid_surface:Surfaces = Surfaces.ALL
var current_surface: Surfaces = Surfaces.WALL

var placed: bool = false

func can_place():
	var no_overlap = !place_area.get_overlapping_areas() and !place_area.get_overlapping_bodies()
	var correct_surface = current_surface==valid_surface or valid_surface == Surfaces.ALL
	return no_overlap and correct_surface

func _ready():
	model.hide()
	place_area.collision_layer = 16
	place_area.collision_mask = 16
	placement_guide.material_override = placement_guide.get_material_override().duplicate()

func place():
	emit_signal("just_placed")
	placed = true
	model.show()
	placement_guide.hide()
	place_area.collision_layer = 0
	place_area.collision_mask = 0

func _process(delta):
	if can_place():
		placement_guide.get_material_override().set_albedo(Color.GREEN)
	else:
		placement_guide.get_material_override().set_albedo(Color.RED)
