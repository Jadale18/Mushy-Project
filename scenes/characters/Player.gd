extends KinematicBody2D




# Exported Vars
export var speed = 20000




# Other Vars
var velocity = Vector2.ZERO




#Functions
func _physics_process(delta):
	velocity = Vector2.ZERO
	check_input()
	velocity = move_and_slide(velocity * speed * delta)

func check_input():
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	

