extends PanelContainer

var highlighted:bool = false :set=set_highlighted

func set_highlighted(val:bool):
	highlighted = val
	$Highlight.visible = val

func set_item(item:TrapData):
	if !item:return
	$Icon.set_texture(item.icon)
