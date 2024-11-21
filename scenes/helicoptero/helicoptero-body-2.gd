extends Node2D

@onready var puntas: DampedSpringJoint2D = $"Grabby Left/Punta Left/PuntaSpring"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var agarrando_caja = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("agarrar_caja-0"):
		print(agarrando_caja)
		if(agarrando_caja):
			puntas.rest_length = 5
			agarrando_caja = not agarrando_caja
		elif (not agarrando_caja):
			puntas.rest_length = 30
			agarrando_caja = not agarrando_caja
