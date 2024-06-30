extends StaticBody3D

var interacting_body = null
#Menu display
#Left and right buttons change the display
#
func _on_interaction_handler_interaction_start(body):
	if !body.is_in_group("player"):return
	interacting_body = body


func _on_interaction_handler_interaction_end(body):
	if body != interacting_body:return
	interacting_body = body
