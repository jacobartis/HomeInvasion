extends Control

signal inventory_update(inventory:Dictionary)
signal pos_selected(pos:int)

const HOTBAR_ELEMENT = preload("res://player/UI/hotbar_element.tscn")

const RADIUS = 200

var selected_button = null
var total_dir: Vector2 = Vector2.ZERO

var items: Dictionary = {
	0:preload("res://traps/prox_alarm/prox_alarm.tres"),
	1:null,
	2:preload("res://traps/bear_trap/bear_trap.tres"),
	3:null,
	4:null}

var selected: int = 0

func get_selected_item():
	return items[selected]

func _ready():
	generate_inventory(items)
	emit_signal("inventory_update",items)

func generate_inventory(inv:Dictionary):
	for x in get_tree().get_nodes_in_group("center_obj"):
		x.queue_free()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	var rad_shift = (2*PI)/inv.size()
	var ang = 3*PI/2
	for item in inv.values():
		var point = Vector2(RADIUS*cos(ang),RADIUS*sin(ang))+$Center.position
		var button = HOTBAR_ELEMENT.instantiate()
		var center_con = CenterContainer.new()
		center_con.use_top_left = true
		add_child(center_con)
		center_con.add_to_group("center_obj")
		center_con.position = point
		center_con.add_child(button)
		button.set_item(item)
		button.add_to_group("invent_button")
		ang += rad_shift

func _process(delta):
	var polygon = %Arrow.polygon
	polygon[0] = polygon[0].move_toward(Vector2(10,0),delta*polygon[0].length()/2)
	%Arrow.polygon = polygon
	total_dir = total_dir.move_toward(total_dir.normalized(),delta*total_dir.length())

func _input(event):
	event = event as InputEventMouseMotion
	if !event: return
	total_dir += event.relative
	point_arrow(event)
	if total_dir.length()<10:return
	var buttons = get_tree().get_nodes_in_group("invent_button")
	buttons.sort_custom(
		func (a,b):
			return a.global_position.dot(total_dir)>b.global_position.dot(total_dir)
	)
	if !buttons: return
	if selected_button and selected_button != buttons.front(): selected_button.highlighted = false
	selected_button = buttons.front()
	if !selected_button: return
	selected_button.highlighted = true

func point_arrow(event:InputEventMouseMotion):
	%Arrow.look_at(%Arrow.global_position+total_dir)
	var polygon = %Arrow.polygon
	polygon[0] += Vector2(2*event.relative.length()/polygon[0].length(),0)
	%Arrow.polygon = polygon

func remove_selected():
	items[position] = null
	emit_signal("inventory_update",items)
	emit_signal("pos_selected",position)

func next_item():
	if items.is_empty():return
	selected = (selected+1)%items.size()
	emit_signal("pos_selected",position)

func prev_item():
	if items.is_empty():return
	selected = (selected-1)%items.size()
	if selected<0:
		selected = items.size()-1
	emit_signal("pos_selected",selected)

#TODO Update this to work
func add_item(item:TrapData=null):
	if !item: return
	items[position] = item
	emit_signal("inventory_update",items)
	emit_signal("pos_selected",position)
