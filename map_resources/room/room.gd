extends Resource
class_name Room

var sections: Array[RoomSection] = []:get=get_sections
var player_entries: int = 0

func get_sections():
	sections.sort_custom(
		func(a,b):
			return a.player_entries>b.player_entries
	)
	return sections

func get_rand_pos():
	return sections.pick_random().global_position

func get_hiding_spots(min_time:int=0):
	var hs = []
	for section in sections:
		hs.append_array(section.get_hiding_spots())
	var current = Time.get_ticks_msec()
	return hs.filter(
		func(spot): return current-spot.last_search>min_time
	)

func add_section(section:RoomSection):
	if !section or sections.has(section): return
	section.connect("body_entered",section_entered)
	if section.doorway: return
	sections.append(section)

func remove_section(section:RoomSection):
	if !section or sections.has(section): return
	sections.erase(section)
	section.disconnect("body_entered",section_entered)
	if sections.is_empty():
		free()

func section_entered(body:Node3D):
	if !(body.is_in_group("enemy") or body.is_in_group("player")): return
	if body.is_in_group("player") and body.get_room() != self:
		player_entries += 1
	body.set_room(self)

func sort_furthest(pos:Vector3,list:Array):
	list.sort_custom(
		func(a,b):
			return pos.distance_to(a.global_position)>pos.distance_to(b.global_position)
	)
	return list

func sort_closest(pos:Vector3,list:Array):
	list.sort_custom(
		func(a,b):
			return pos.distance_to(a.global_position)<pos.distance_to(b.global_position)
	)
	return list
