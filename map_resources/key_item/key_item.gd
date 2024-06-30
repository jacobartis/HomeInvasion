@tool
extends Node3D

var key_val: int = 0

@export var properties: Dictionary :
	get:
		return properties
	set(new_properties):
		if(properties != new_properties):
			properties = new_properties
			update_properties()

func update_properties():
	if "key_value":
		update_key(properties['key_value'])

func update_key(val:int):
	if val<0 or val>2:
		val = 0
	key_val = val
	$Sprite3D.texture = $Sprite3D.texture.duplicate()
	var region = $Sprite3D.texture.region 
	$Sprite3D.texture.region = Rect2(Vector2(region.size.x*val,0),region.size)

func _on_area_3d_body_entered(body):
	if !body.is_in_group("player") or !visible:return
	body.inventory_manager.set_key(key_val,true)
	hide()
	$PickupSound.play()
	await $PickupSound.finished
	queue_free()
