extends StaticBody3D
class_name Trap

signal just_placed()

@onready var placement_guide = $PlacementGuide
@onready var place_area = $PlaceArea
@onready var model = $Model

@export var place_offset: Vector3

var placed: bool = false

var duration: float = 1.5

func can_place():
	return !place_area.get_overlapping_bodies()

func _ready():
	model.hide()
	placement_guide.material_override = placement_guide.get_material_override().duplicate()

func place():
	if !can_place():
		queue_free()
	emit_signal("just_placed")
	placed = true
	model.show()
	placement_guide.hide()
	set_collision_layer(2)
	set_collision_mask(2)

func activate():
	pass

func _on_trigger_area_body_entered(body):
	if !body.is_in_group("enemy") or !placed:
		return
	body.stun(2)
	queue_free()

func duration_timeout():
	queue_free()

func _process(delta):
	
	if can_place():
		placement_guide.get_material_override().set_albedo(Color.GREEN)
	else:
		placement_guide.get_material_override().set_albedo(Color.RED)
