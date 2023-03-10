extends KinematicBody2D




# Exported Vars
export var speed = 200
export var player_gravity = 20
export var jump_impulse = 500




# Other Vars
var velocity = Vector2.ZERO




#Functions
func _physics_process(delta):
	velocity.x = 0
	apply_gravity()
	check_input()
	if velocity.x == 0:
		$AnimatedSprite.speed_scale = 0.5
		$AnimatedSprite.play("Idle")
	else:
		$AnimatedSprite.speed_scale = 1.3
		$AnimatedSprite.play("Walk")
		
	
	if not is_on_floor():
		$AnimatedSprite.play("Fall")
	velocity.x *= speed
	velocity = move_and_slide(velocity, Vector2.UP)

func check_input():
	if Input.is_action_pressed('left'):
		$AnimatedSprite.flip_h = false
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		$AnimatedSprite.flip_h = true
		velocity.x += 1
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_impulse

func apply_gravity():
	velocity.y += player_gravity
	velocity.y = min(velocity.y, 30000)
	

