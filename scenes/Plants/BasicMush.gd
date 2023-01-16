extends Area2D

var spores = 0
var can_harvest = false
var placing = false
var placing_possible = false
var placing_on_another_mush = false
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
	position.x = get_global_mouse_position().x
	position.y = int(get_global_mouse_position().y) - (int(get_global_mouse_position().y) % 32) + 16
	if $RayCastBelow.get_collider() and $RayCastBelow2.get_collider():
		if $RayCastBelow.get_collider().get("name") == 'FirstTiles' and $RayCastBelow2.get_collider().get("name") == 'FirstTiles':
			placing_possible = true
	else:
		placing_possible = false
	
	if $RayCastAbove.get_collider() or $RayCastAbove2.get_collider():
		placing_possible = false
	if placing_on_another_mush:
		placing_possible = false
		
	if not placing_possible:
		$AnimatedSprite.modulate = Color(1,0,0,0.5)
	else:
		$AnimatedSprite.modulate = Color(1,1,1,1)
	if Input.is_action_just_pressed("left_click") and placing_possible:
		placing = false
		placing_possible = false
	


func _on_BasicMush_area_entered(area):
	if 'BasicMush' in area.name:
		placing_on_another_mush = true


func _on_BasicMush_area_exited(area):
	if 'BasicMush' in area.name and placing_on_another_mush:
		placing_on_another_mush = false
