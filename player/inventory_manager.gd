extends Node

signal inventory_update(inventory)
signal item_selected(item)

var items: Dictionary = {}
var position: int = 0

func get_selected_item():
	if items.is_empty():return null
	var item = items.keys()[position]
	items[item] -= 1
	
	if items[item]<=0:
		items.erase(item)
	
	position = clamp(position,0,items.size()-1)
	emit_signal("inventory_update",items)
	
	if items.is_empty():
		emit_signal("item_selected",null)
	else:
		emit_signal("item_selected",items.keys()[position])
	
	return item.instantiate()

func _process(delta):
	if items.is_empty():return
	if Input.is_action_just_pressed("next_item"):
		position = (position+1)%items.size()
	if Input.is_action_just_pressed("prev_item"):
		position = (position-1)%items.size()
	emit_signal("item_selected",items.keys()[position])

func add_item(item:PackedScene=null):
	if items.has(item):
		items[item] += 1
	else:
		items[item] = 1
	emit_signal("inventory_update",items)
