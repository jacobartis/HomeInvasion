extends Control

@onready var timer_label = $HBoxContainer/Timer
@onready var title_label = $HBoxContainer/Title

var timer:Timer = null

func set_display(new_timer, title):
	set_timer(new_timer)
	set_title(title)

func set_timer(new_timer:Timer):
	timer = new_timer

func set_title(title:String):
	title_label.set_text(title)

func _process(delta):
	if !timer:return
	timer_label.set_text(str(snapped(timer.time_left,0.01)))
