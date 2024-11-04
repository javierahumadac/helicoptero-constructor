extends RigidBody2D

var VELOCIDAD_MAXIMA_AGARRE = 35

var agarrando_caja = false
func _process(delta):
	if Input.is_action_just_pressed("agarrar_caja-0"):
		agarrando_caja = not agarrando_caja
	if(agarrando_caja):
		angular_velocity = 10
	if(not agarrando_caja):
		angular_velocity = -20
		
