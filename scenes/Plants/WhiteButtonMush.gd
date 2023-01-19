extends Area2D

var spores = 0
var can_harvest = false
var placing = false
signal harvest(amt, type)


func _process(delta):
	if placing:
		place()
	elif can_harvest and Input.is_action_just_pressed("Interact") and spores > 0:
		emit_signal("harvest", spores, "wbutton")
		spores = 0
		$ProducedLabel.text = 'No spores to harvest :('


func _on_ProductionTimer_timeout():
	spores += 1
	$ProducedLabel.text = 'Harvest ' + var2str(spores) + ' spore(s)'

func place():
	pass

func _on_WhiteButtonMush_body_entered(body):
	if body.name == 'Player':
		$ProducedLabel.visible = true
		can_harvest = true


func _on_WhiteButtonMush_body_exited(body):
	if body.name == 'Player':
		$ProducedLabel.visible = false
		can_harvest = false


func _on_WhiteButtonMush_area_entered(area):
	pass # Replace with function body.


func _on_WhiteButtonMush_area_exited(area):
	pass # Replace with function body.
