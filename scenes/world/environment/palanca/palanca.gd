extends Node2D

# Nodos requeridos:
# - PinJoint2D (para el punto de pivote)
# - RigidBody2D (para la palanca)
# - CollisionShape2D (para la física de la palanca)
# - Sprite2D (opcional, para la visual de la palanca)
#
@onready var lever = $RigidBody2D
@onready var pin_joint = $PinJoint2D
#
# Configuración de la palanca
@export var rotation_limit = PI/4  # Límite de rotación (45 grados)
@export var return_force = 10000     # Fuerza de retorno al centro

func _ready():
	#pass
	## Configura el joint
	#pin_joint.node_a = self.get_path()
	#pin_joint.node_b = lever.get_path()
	#
	# Aplica límites de rotación
	lever.rotation = 0
	lever.angular_damp = 1.0
	lever.gravity_scale = 0.0

var activated = false
signal _on_lever_activated()

func _physics_process(delta):
	# Aplica fuerza de retorno al centro
	var current_rotation = lever.rotation
	var return_direction = -sign(current_rotation)
	var force = return_direction * return_force * abs(current_rotation)
	lever.apply_torque(force * delta)
	
	# Limita la rotación
	if abs(current_rotation) > rotation_limit:
		lever.rotation = rotation_limit * sign(current_rotation)
		lever.angular_velocity = 0
		if(not activated):
			activated = true
			emit_signal("_on_lever_activated")
	else:
		activated = false
