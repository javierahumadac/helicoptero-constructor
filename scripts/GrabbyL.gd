extends RigidBody2D

func _process(delta):
	if Input.is_key_pressed(KEY_Z):
		angular_velocity += 1
		angular_velocity = clamp(angular_velocity,0,5)
	if Input.is_key_pressed(KEY_X):
		angular_velocity -= 5
		angular_velocity = clamp(angular_velocity,0,-15)
		
