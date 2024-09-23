extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.


func _physics_process(delta):
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	var up_down = Input.get_axis("Up", "Down")
	
	if direction and up_down:
		velocity.x = direction * SPEED
		velocity.y = up_down * SPEED
	elif direction:
		velocity.x = direction * SPEED
	elif up_down:
		velocity.y = up_down * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
