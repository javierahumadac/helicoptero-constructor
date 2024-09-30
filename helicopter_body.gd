extends RigidBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var gancho = $Gancho

var thrust_upward = Vector2.UP * 1000
var thrust_right = Vector2.RIGHT * 1000
var thrust_left = Vector2.LEFT * 1000
var thrust_down = Vector2.DOWN * 1000

const MAX_ANGLE = 45.0
const MAX_LINEAR_VELOCITY_X = 200.0  # Ajusta este valor según la velocidad máxima en X
const MAX_ANGULAR_VELOCITY = 5.0  # Ajusta según la velocidad de giro deseada

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _integrate_forces(state):
	var thrust: Vector2
	if Input.is_action_pressed("fly_up-0"):
		thrust = thrust_upward
	elif Input.is_action_pressed("fly_down-0"):
		thrust = thrust_down
	else:
		thrust = Vector2.ZERO
	
	if Input.is_action_pressed("right-0"):
		thrust += thrust_right
		
	elif Input.is_action_pressed("left-0"):
		thrust += thrust_left

	# Obtener la velocidad lineal en el eje X
	var velocity_x = linear_velocity.x

	# Obtener el ángulo actual del objeto en grados
	var current_angle = rotation_degrees
	
	var target_angle = clamp(lerp(0.0, MAX_ANGLE, abs(velocity_x) / MAX_LINEAR_VELOCITY_X), 0.0, MAX_ANGLE)
	
	# Aplicar el signo de la velocidad a la rotación
	if velocity_x < 0:
		target_angle = -target_angle
	
	# Calcular la diferencia entre el ángulo actual y el objetivo
	var angle_difference = target_angle - current_angle
	
	# Mapear esa diferencia a la velocidad angular
	angular_velocity = clamp(angle_difference * 0.1, -MAX_ANGULAR_VELOCITY, MAX_ANGULAR_VELOCITY)
	
	apply_force(thrust)

func _process(delta):
	pass #print("helicoptero", rotation)
	
