extends RigidBody2D

var agarrando_caja = false
func _process(delta):
	if Input.is_action_just_pressed("agarrar_caja-0"):
		agarrando_caja = not agarrando_caja
	if(agarrando_caja):
		angular_velocity = -5
	if(not agarrando_caja):
		angular_velocity = 15
		
