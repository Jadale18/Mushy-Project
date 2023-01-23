extends Area2D

var spores = 0
var can_harvest = false
var placing = false
var placing_possible = false
var placing_on_another_mush = false
var placing_count = 0
signal harvest(amt, type)
signal place(cost, type)
export var autostart = false

func _ready():
	if autostart:
		$ProductionTimer.start()

func _process(delta):
	if placing:
		place()
	elif can_harvest and Input.is_action_just_pressed("Interact") and spores > 0:
		emit_signal("harvest", spores, "basic")
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
	if rotation_degrees in [0, 180]:
		position.x = get_global_mouse_position().x
		position.y = int(get_global_mouse_position().y) - (int(get_global_mouse_position().y) % 32) + 16
	else:
		position.x = int(get_global_mouse_position().x) - (int(get_global_mouse_position().x) % 32) + 16
		position.y = get_global_mouse_position().y
	check_rotation()
	if $RayCastBelow.get_collider() and $RayCastBelow2.get_collider():
		if $RayCastBelow.get_collider().get("name") == 'FirstTiles' and $RayCastBelow2.get_collider().get("name") == 'FirstTiles':
			placing_possible = true
	else:
		placing_possible = false
	
	if $RayCastAbove.get_collider():
		if $RayCastAbove.get_collider().get("name") == 'FirstTiles':
			placing_possible = false
			
	if $RayCastAbove2.get_collider():
		if $RayCastAbove2.get_collider().get("name") == 'FirstTiles':
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
		$ProductionTimer.start()
		emit_signal("place", 5, "basic")
	
func check_rotation():
	if Input.is_action_just_pressed("rotate_placement"):
		rotation_degrees += 90
		if rotation_degrees == 360:
			rotation_degrees = 0

func _on_BasicMush_area_entered(area):
	if 'Mush' in area.name:
		placing_count += 1
		placing_on_another_mush = true



func _on_BasicMush_area_exited(area):
	if 'Mush' in area.name and placing_on_another_mush:
		placing_count -= 1
		if placing_count == 0:
			placing_on_another_mush = false

