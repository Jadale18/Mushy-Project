extends Area2D

var spores = 0
var can_harvest = false
var placing = false
signal harvest(amt)


func _process(delta):
	if placing:
		place()
	elif can_harvest and Input.is_action_just_pressed("Interact") and spores > 0:
		emit_signal("harvest", spores)
		spores = 0
		$ProducedLabel.text = 'No spores to harvest :('

func _on_ProductionTimer_timeout():
	spores += 1
	$ProducedLabel.text = 'Harvest ' + var2str(spores) + ' spore(s)'


func _on_BasicMush_body_entered(body):
	if body.name == 'Player':
		$ProducedLabel.visible = true
		can_harvest = true


func _on_BasicMush_body_exited(body):
	if body.name == 'Player':
		$ProducedLabel.visible = false
		can_harvest = false

func place():
	position = get_global_mouse_position()
	if Input.is_action_just_pressed("left_click"):
		placing = false
	
