extends StaticBody3D

signal trigger(duration)

var can_be_pressed:bool = true
var duration: float = 5
var cooldown: float = 10

@export var properties: Dictionary :
	get:
		return properties
	set(new_properties):
		if(properties != new_properties):
			properties = new_properties
			update_properties()

func update_properties():
	if "duration" in properties:
		duration = properties["duration"]
	if "cooldown" in properties:
		cooldown = properties["cooldown"]
	if "angle" in properties:
		rotation.y = deg_to_rad(float(properties["angle"])-180)

func _process(delta):
	var time_left = $DurationTimer.time_left
	if !time_left: 
		if !can_be_pressed:
			var dots = ""
			for x in roundi(Time.get_ticks_msec()/500)%4:
				dots = dots+"."
			$TimeDisplay.set_text("CHARGING"+dots) 
			return
		$TimeDisplay.set_text("") 
		return
	if time_left>10: 
		time_left = round(time_left)
	else:
		time_left = snapped(time_left,0.1)
	$TimeDisplay.set_text(str(time_left))


func use(duration) -> void:
	disable()
	$CooldownTimer.start(duration)

func _ready():
	enable()

func interact(interactor):
	if can_be_pressed:
		$UseAudio.play(.1)
		activate()

func enter_cooldown():
	disable()
	$CooldownTimer.start(cooldown)

func activate():
	trigger.emit(duration)
	can_be_pressed = false
	$DurationTimer.start(duration)
	hide_displays()
	$DisplayYellow.show()

func enable():
	can_be_pressed = true
	$ChargingAudio.stop()
	hide_displays()
	$DisplayGreen.show()

func disable():
	can_be_pressed = false
	$ChargingAudio.play()
	hide_displays()
	$DisplayRed.show()

func hide_displays():
	$DisplayGreen.hide()
	$DisplayRed.hide()
	$DisplayYellow.hide()

func _on_charging_audio_finished():
	await get_tree().create_timer(randf_range(1,3)).timeout
	$ChargingAudio.play()
