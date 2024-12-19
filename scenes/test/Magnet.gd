extends RigidBody2D

@onready var captureZone : Area2D = $CaptureZone
@onready var union : PinJoint2D = $Joint
@onready var sprite = $Sprite2D  # Asegúrate de tener una referencia al sprite del imán

@export var player_id : int = 0

# Variables para el parpadeo
var blink_time : float = 0.0
var blink_rate : float = 10.0  # Velocidad del parpadeo
var original_color : Color

func _ready():
	original_color = sprite.modulate

var agarrando_caja = false
var body_agarrado = false

func _process(delta):
	if Input.is_action_just_pressed("agarrar_caja-" + str(player_id)):
		agarrando_caja = not agarrando_caja
		
	if(not agarrando_caja and body_agarrado):
		union.node_b = ""
		body_agarrado = false
		sprite.modulate = original_color  # Restaurar color original
	elif (agarrando_caja and not body_agarrado):
		# Efecto de parpadeo
		blink_time += delta * blink_rate
		var blink_value = (sin(blink_time) + 1.0) / 2.0
		sprite.modulate = original_color.lerp(Color(1, 1, 1, 0.3), blink_value)
		
		# INTENTAR DE AGARRAR CAJA
		if(captureZone.has_overlapping_bodies()):
			for b in captureZone.get_overlapping_bodies():
				union.node_b = b.get_path()
				body_agarrado = true
				sprite.modulate = original_color  # Restaurar color original cuando agarra
				break
