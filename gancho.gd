extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	enganchar_body(delta)

var cajaEnganchada : RigidBody2D
var hayCajaEnganchada = false
func enganchar_body(delta):
	if(hayCajaEnganchada):
		cajaEnganchada.move_body(get_parent().position + $AreaDeEnganche.position)
		if(Input.is_action_pressed("botar_caja")):
			hayCajaEnganchada = false
			#cajaEnganchada.set_sleeping(false)
			#cajaEnganchada.set_can_sleep(false)
			

func _on_body_entered(body):
	if(not hayCajaEnganchada):
		print(body)
		#body.set_can_sleep(true)
		#body.set_sleeping(true)
		#sleeping [predeterminado: false]set_sleeping(valor) setteris_sleeping() getter
		cajaEnganchada = body
		hayCajaEnganchada = true


func _on_area_2d_body_entered(body):
	pass
