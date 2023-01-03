extends Area2D

var spores = 0



func _on_ProductionTimer_timeout():
	spores += 1
	$ProducedLabel.text = var2str(spores)


func _on_BasicMush_body_entered(body):
	if body.name == 'Player':
		$ProducedLabel.visible = true


func _on_BasicMush_body_exited(body):
	if body.name == 'Player':
		$ProducedLabel.visible = false
