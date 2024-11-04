extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var SPEED = 100.0
@export var gravity = 980
@export var fly_force = 1300
@export var velocity_y_max = -250.0
@export var push_force = 200.0
@export var pitch_min = 0.8 # Pitch mínimo
@export var pitch_max = 2.0 # Pitch máximo
@export var player_number = 0


@onready var audio = $Audio
@onready var wind = $"Wind Falling"

@onready var gancho = $Gancho


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta * 0.5

	# Handle jump.
	if Input.is_action_pressed("fly_up-" + str(player_number)):
		velocity.y -= fly_force * delta
		velocity.y = clampf(velocity.y, velocity_y_max, velocity.y)
		#print(velocity.y)
	
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left-" + str(player_number), "right-" + str(player_number))
	if direction and not is_on_floor():
		velocity.x = move_toward(velocity.x, direction * SPEED, 3) 
	elif not is_on_floor():
		velocity.x = move_toward(velocity.x, 0, 0.1)
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, 5)
	
	if(Input.is_action_just_pressed("agarrar_caja-" + str(player_number))):
		gancho.tratando_de_agarrar_caja = not gancho.tratando_de_agarrar_caja
	
	move_and_slide()
	helicopter_sound()

func helicopter_sound():
	# Cambia el pitch del sonido en función de la velocidad vertical
	var speed_factor = - velocity.y / fly_force
	print(speed_factor)
	audio.pitch_scale = lerp(pitch_min, pitch_max, clamp(speed_factor, 0.0, 1.0))
	
	#wind.pitch_scale = lerp(pitch_min, pitch_max, clamp(speed_factor, 0.0, 1.0))
	#wind.volume_db = lerp(-10.0, 5.0, clamp(abs(speed_factor), 0.0, 1.0))
	
	if is_on_floor():
		audio.stop()
		#wind.stop()
	elif not audio.playing:
		audio.play()
