extends ColorRect

func _process(delta):
	if Input.is_action_just_pressed("Inventory"):
		visible = not visible
