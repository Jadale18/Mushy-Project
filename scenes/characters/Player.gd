extends KinematicBody2D




# Exported Vars
export var speed = 20000
export var player_gravity = 1
export var jump_impulse = 1




# Other Vars
var velocity = Vector2.ZERO




#Functions
func _physics_process(delta):
	velocity.x = 0
	velocity.y += player_gravity
	check_input()
	
	velocity = move_and_slide(velocity * speed * delta)

func check_input():
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	print(is_on_floor())
	if Input.is_action_just_pressed("jump"):
		print('j')
		velocity.y = -jump_impulse

func apply_gravity():
	velocity.y += player_gravity
	velocity.y = min(velocity.y, 300)
	

