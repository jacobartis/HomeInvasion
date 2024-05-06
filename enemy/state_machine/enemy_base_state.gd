extends Node
class_name EnemyState

enum State{
	None,
	Idle,
	Curious,
	Aggressive,
	Tactical,
	Chase,
	Invesigation
}

var body

func init(new_body):
	body = new_body

func enter():
	pass

func exit():
	body.action_controller.clear_action()

func process(delta) -> State:
	return State.None

func physics_process(delta):
	pass

func input(event):
	pass
