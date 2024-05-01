extends Resource
class_name Room

var sections: Array[RoomSection] = []:get=get_sections
var player_entries: int = 0

func get_sections():
	return sections

func get_rand_pos():
	return sections.pick_random().global_position

func get_furthest_section(pos:Vector3):
	var ordered = sections.duplicate()
	ordered.sort_custom(
		func(a, b):
			return pos.distance_to(a.global_position)>pos.distance_to(b.global_position)
	)
	return ordered[0]

func get_closest_section(pos:Vector3):
	var ordered = sections.duplicate()
	ordered.sort_custom(
		func(a, b):
			return pos.distance_to(a.global_position)<pos.distance_to(b.global_position)
	)
	return ordered[0]

func get_hiding_spots():
	var hs = []
	for section in sections:
		hs.append_array(section.get_hiding_spots())
	return hs

func get_furthest_hiding_spot(pos:Vector3):
	var ordered = get_hiding_spots()
	ordered.sort_custom(
		func(a, b):
			return pos.distance_to(a.global_position)>pos.distance_to(b.global_position)
	)
	return ordered[0]

func get_closest_hiding_spot(pos:Vector3):
	var ordered = get_hiding_spots()
	ordered.sort_custom(
		func(a, b):
			return pos.distance_to(a.global_position)<pos.distance_to(b.global_position)
	)
	return ordered[0]

func add_section(section:RoomSection):
	if !section or sections.has(section): return
	sections.append(section)
	section.connect("body_entered",section_entered)

func remove_section(section:RoomSection):
	if !section or sections.has(section): return
	sections.erase(section)
	section.disconnect("body_entered",section_entered)
	if sections.is_empty():
		free()

func section_entered(body:Node3D):
	if !(body.is_in_group("enemy") or body.is_in_group("player")): return
	if body.is_in_group("player"):
		player_entries += 1
	body.set_room(self)
