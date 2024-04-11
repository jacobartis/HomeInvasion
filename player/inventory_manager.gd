extends Node

signal inventory_update(inventory)
signal item_selected(item)

var items: Dictionary = {}
var position: int = 0

func get_selected_item():
	if items.is_empty():return null
	return items.keys()[position]

func remove_selected():
	if items.is_empty():return null
	var item = get_selected_item()
	items[item] -= 1
	
	if items[item]<=0:
		items.erase(item)
	
	position = clamp(position,0,items.size()-1)
	emit_signal("inventory_update",items)
	
	if items.is_empty():
		emit_signal("item_selected",null)
	else:
		emit_signal("item_selected",get_selected_item())

func next_item():
	if items.is_empty():return
	position = abs(position+1)%items.size()
	emit_signal("item_selected",items.keys()[position])

func prev_item():
	if items.is_empty():return
	position = abs(position-1)%items.size()
	emit_signal("item_selected",items.keys()[position])

func add_item(item:TrapData=null):
	if items.has(item):
		items[item] += 1
	else:
		items[item] = 1
	if items.keys().size()==1:
		emit_signal("item_selected",get_selected_item())
	emit_signal("inventory_update",items)
