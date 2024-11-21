extends RigidBody2D

@onready var captureZone : Area2D = $CaptureZone
@onready var union : PinJoint2D = $Joint


@export var player_id : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


var agarrando_caja = false
var body_agarrado = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("agarrar_caja-" + str(player_id)):
		agarrando_caja = not agarrando_caja
	if(not agarrando_caja and body_agarrado):
		union.node_b = ""
		body_agarrado = false
	elif (agarrando_caja and not body_agarrado):
		# INTENTAR DE AGARRAR CAJA
		if(captureZone.has_overlapping_bodies()):
			for b in captureZone.get_overlapping_bodies():
				union.node_b = b.get_path()
				body_agarrado = true
				break
