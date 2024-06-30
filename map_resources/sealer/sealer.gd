extends StaticBody3D

@onready var interaction_handler:InteractionHandler = $InteractionHandler

func interact(body):
	get_tree().call_group("compass","recharge")
	$Gem1.visible = body.inventory_manager.get_keys()[0]
	$Gem2.visible = body.inventory_manager.get_keys()[1]
	$Gem3.visible = body.inventory_manager.get_keys()[2]
	if $Gem1.visible and $Gem2.visible and $Gem3.visible:
		print("Game win!")
