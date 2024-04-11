extends Node
class_name PlayerState

enum State {
	None,
	Idle,
	Walking,
	Sprint,
	Hiding,
	Crafting
}

var body

func init(new_body):
	body = new_body

func enter():
	pass

func exit():
	pass

func process(delta) -> State:
	return State.None

func physics_process(delta):
	pass

func input(event):
	pass
