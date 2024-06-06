extends Node

signal menace_update(val)

var menace: float = 0: set=set_menace

var rooms: Dictionary = {} : get=get_rooms

func set_menace(val):
	menace = clamp(val,0,INF)
	menace_update.emit(menace)

func get_rooms() -> Dictionary:
	return rooms

func get_rooms_array() -> Array:
	var room_array = []
	for room in rooms.values():
		room_array.append(room)
	return room_array

func get_id(room:Room):
	for key in rooms.keys():
		if rooms[key]:
			return key
	return -1

func add_room_section(room_section:RoomSection):
	if !rooms.has(room_section.room_id):
		var new_room = Room.new()
		new_room.add_section(room_section)
		rooms[room_section.room_id] = new_room
	else:
		rooms[room_section.room_id].add_section(room_section)
	check_valid()

#Removes empty rooms
func check_valid():
	for key in rooms.keys():
		if !rooms[key]:
			rooms.erase(key)
