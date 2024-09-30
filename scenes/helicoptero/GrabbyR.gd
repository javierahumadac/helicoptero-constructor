extends RigidBody2D

var extend = false
var rotation_count = 0

func _process(delta):
	if Input.is_action_just_pressed("agarrar_caja-0"):
		extend = not extend
		lock_rotation = false
	
	if(extend):
		#rotation_count += 1
		angular_velocity -= 1
		angular_velocity = clamp(angular_velocity,0,-5)
		#if(rotation_count < 100):
		#else:
			#lock_rotation = true
	#if(not extend):
		#if(rotation_count > 0):
		#rotation_count -= 5
		#rotation_count = clamp(rotation_count, 0, 100)
		#angular_velocity += 5
		#angular_velocity = clamp(angular_velocity,0,15)
		#else:
			#lock_rotation = true
	print(extend, rotation_count, lock_rotation, rotation)
		
