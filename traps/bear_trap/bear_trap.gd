extends Trap

@export var trigger_area:Area3D

var triggered:bool = false:
	set(val):
		triggered = val
		$TriggerArea/InteractionHandler.enabled = triggered

##TODO Add stunned/trapped state for players and enemies
func _on_trigger_area_body_entered(body):
	if triggered or !placed: return
	if !body.is_in_group("player") and !body.is_in_group("enemy"): return
	print(body," was hit by trap")
	triggered = true

func _on_interaction_handler_interaction_end(body):
	triggered = false
