extends EnemyAction

signal new_action(action)
signal action_finished(action)

@onready var actions = {
	EnemyAction.Actions.Search: $SearchAction
}

var current_action: EnemyAction

func init(new_body):
	super(new_body)
	for action in actions:
		actions[action].init(new_body)

func clear_action():
	current_action = null

func enter(args:Dictionary):
	current_action = actions[args["action"]]
	current_action.enter(args)
	emit_signal("new_action",current_action)

func process(delta):
	if !current_action: return false
	var finished = current_action.process(delta)
	if finished:
		emit_signal("action_finished",current_action)
		current_action = null
		return true
	return false

func physics_process(delta):
	if !current_action: return
	current_action.physics_process(delta)
