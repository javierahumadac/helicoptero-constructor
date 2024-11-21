extends Node2D

@export var square_1x1_body_scene: PackedScene  # Asigna la escena en el editor
@export var square_2x1_body_scene: PackedScene  # Asigna la escena en el editor
@export var square_3x1_body_scene: PackedScene  # Asigna la escena en el editor
@export var boxes_container: Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _check_completed():
	var children = get_children()
	var current_count = 0
	
	for c in children:
		if c.is_in_group("Area Box"):
			if (c.is_area_completed):
				current_count += 1
				
	if(current_count == 1):
		return square_1x1_body_scene
	elif(current_count == 2):
		return square_2x1_body_scene
	elif(current_count == 3):
		return square_3x1_body_scene
	else:
		return null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var planning_to_shoot = false

func shoot_box(spawning_box):
	if(spawning_box):
		# Instanciar el square_body
		var box = spawning_box.instantiate()
		# Añadirlo a la escena
		boxes_container.add_child(box)

		# Posicionar el cuadrado sobre este nodo
		box.global_position = $Spawner.global_position

		# Aplicar impulso hacia arriba y un poco aleatorio a los lados
		var impulse = Vector2(300, -300)  # Ajusta estos valores según necesites
		box.apply_impulse(impulse)

func _on_pressureplate_body_entered(body):
	if not planning_to_shoot:
		planning_to_shoot = true
		
		var spawning_box = _check_completed()
		if(spawning_box):
			# Abrir puerta de destrucción
			print("abriendo puertas de destrucción")
			disable_stopper()
			await get_tree().create_timer(3.0).timeout
			print("Cerrando puertas de destrucción")
			# Cerrar puerta de destrucción
			enable_stopper()
			
			await get_tree().create_timer(3.0).timeout
			# Disparar caja
			shoot_box(spawning_box)
		planning_to_shoot = false

# Funciones auxiliares para mejor legibilidad
func disable_stopper():
	var tween = create_tween()
	tween.tween_property($Stopper, "position", 
		$Stopper.position + Vector2(0, 10), 0.1)  # Mueve 10 pixels abajo

	# Esperar a que termine el movimiento
	await tween.finished
	$Stopper.set_collision_layer_value(1, false)
	$Stopper.set_collision_mask_value(1, false)

func enable_stopper():
	$Stopper.position = $Stopper.position - Vector2(0, 10)
	$Stopper.set_collision_layer_value(1, true)
	$Stopper.set_collision_mask_value(1, true)

func _on_delete_zone_body_entered(body):
	body.free()
