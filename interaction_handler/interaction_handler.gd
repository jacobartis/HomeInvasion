extends Node
class_name InteractionHandler

signal interaction_start(body)
signal interaction_end(body)
signal interaction_canceled(body)
signal interaction_finished(body)

@export var interaction_msg:String = "interact"
@export var duration: float = 0.0
@export var can_be_exited: bool = true

var enabled:bool = true
var current_body = null
var current_time = 0

func _process(delta):
	current_time = clamp(current_time-delta,0,INF)
	if current_body and !current_time:
		finish_interact()

func interact(body):
	if current_body: return
	interaction_start.emit(body)
	current_time = duration
	if duration < 0:
		current_time = INF
	current_body = body

func cancel_interact():
	interaction_end.emit(current_body)
	interaction_canceled.emit(current_body)
	current_body = null

func finish_interact():
	interaction_end.emit(current_body)
	interaction_finished.emit(current_body)
	current_body = null

func _input(event):
	if !current_body:return
	if event.is_action_pressed("player_interact") and can_be_exited:
		call_deferred("cancel_interact")
