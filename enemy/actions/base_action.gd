extends Node
class_name EnemyAction

enum Actions{
	Search,
}
var body

func init(new_body):
	body = new_body

func enter(args:Dictionary):
	print(name,"started: ",args)

func process(delta) -> bool:
	return false

func physics_process(delta):
	pass

func input(event):
	pass
