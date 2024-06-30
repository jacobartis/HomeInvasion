extends StaticBody3D

const KEY_ITEM = preload("res://map_resources/key_item/key_item.tscn")

@onready var interaction_handler:InteractionHandler = $InteractionHandler

#TODO Add sequence generation
var sequence: Array[String] = ["A","B","C"]
var sequence_pos: int = 0

var key_value:int = 0
var active: bool = false

@export var properties: Dictionary :
	get:
		return properties
	set(new_properties):
		if(properties != new_properties):
			properties = new_properties
			update_properties()

func update_properties():
	if "key_value":
		key_value = properties['key_value']

func _ready():
	randmize_seq()

func randmize_seq():
	sequence.clear()
	for x in randi_range(4,6):
		sequence.append(String.chr(randi_range(65,90)))

func spawn_reward():
	var key = KEY_ITEM.instantiate()
	key.key_val = key_value
	get_tree().get_first_node_in_group("world").add_child(key)
	key.global_position = get_tree().get_first_node_in_group("player").global_position
	$AnimationPlayer.play("despawn")
	print("play")
	await $AnimationPlayer.animation_finished
	print("free")
	queue_free()

func _input(event):
	if !active: return
	event = event as InputEventKey
	if !event:return
	if !event.is_pressed(): return
	check_sequence(event)

func check_sequence(button_press):
	if sequence[sequence_pos] != button_press.as_text():
		sequence_pos = 0
		interaction_handler.cancel_interact()
		$WrongAudio.play()
		return
	sequence_pos += 1
	if sequence_pos>=sequence.size():
		spawn_reward()
		interaction_handler.finish_interact()
	else:
		#TODO Find better display method
		get_tree().call_group("minigame_disp","set_text",sequence[sequence_pos])

func on_interact(body):
	if !body.is_in_group("player"):return
	interaction_handler.interaction_msg = "exit"
	sequence_pos = 0
	get_tree().call_group("minigame_disp","set_text",sequence[sequence_pos])
	active = true

func _on_interaction_handler_interaction_end(body):
	if !body.is_in_group("player"):return
	interaction_handler.interaction_msg = "interact"
	get_tree().call_group("minigame_disp","set_text","")
	active = false
