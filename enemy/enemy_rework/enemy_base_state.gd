extends Node
class_name EnemyState

enum State{
	None,
	Idle,
	Curious,
	Search,
	Aggressive,
	Tactical,
	Hunt
}

#Handles internal status for animations
enum Status {
	idle,
	active,
	finished
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
