extends Node2D

@export var player_body: PackedScene  # Asigna la escena en el editor
@export var player_container: Node2D
@export var initial_impulse: float = -400.0  # Fuerza del impulso inicial
@export var spawn_delay: float = 0.5  # Delay entre spawns en segundos
@onready var spawner: Node2D = $Spawner

var active_player_ids: Array[int] = []
var spawn_queue: Array[int] = []
var spawn_allowed: bool = false
var is_spawning: bool = false

# Colores predefinidos para cada jugador
var player_colors = {
	0: Color(1.0, 1.0, 1.0),       # Blanco
	1: Color(0.3, 0.3, 0.3),       # Casi negro
	2: Color(1.0, 0.6, 0.8),       # Rosado
	3: Color(1.0, 0.9, 0.2)        # Amarillo
}

func _ready():
	pass

func _process(_delta):
	if spawn_allowed:
		check_and_queue_players()
		process_spawn_queue()

func enable_spawning() -> void:
	spawn_allowed = true

func disable_spawning() -> void:
	spawn_allowed = false
	spawn_queue.clear()

func check_and_queue_players():
	var connected_joypads = Input.get_connected_joypads()
	
	# Primero, verifica si hay jugadores que necesitan ser eliminados
	for player in player_container.get_children():
		if player.player_id not in connected_joypads:
			player.queue_free()
			active_player_ids.erase(player.player_id)
	
	# Añade a la cola los nuevos jugadores
	for joypad_id in connected_joypads:
		if joypad_id not in active_player_ids and joypad_id not in spawn_queue:
			spawn_queue.append(joypad_id)

func process_spawn_queue():
	if not is_spawning and spawn_queue.size() > 0:
		var next_id = spawn_queue.pop_front()
		spawn_player(next_id)

func get_player_color(id: int) -> Color:
	return player_colors.get(id, Color.WHITE)  # Si no hay color definido, usa blanco

func spawn_player(id: int) -> void:
	if player_body and player_container:
		is_spawning = true
		
		var new_player = player_body.instantiate()
		new_player.player_id = id  # Asigna el ID del jugador
		
		# Posiciona al jugador en el spawner
		new_player.global_position = spawner.global_position
		
		# Aplica el color predefinido según el ID
		new_player.modulate = get_player_color(id)
		
		# Añade el jugador a la escena
		player_container.add_child(new_player)
		active_player_ids.append(id)
		
		# Obtiene el RigidBody2D hijo llamado "Helicoptero"
		var helicoptero = new_player.get_node("Helicoptero")
		if helicoptero and helicoptero is RigidBody2D:
			# Espera un frame para asegurarse de que la física está lista
			await get_tree().process_frame
			# Aplica el impulso al helicóptero
			helicoptero.apply_impulse(Vector2(initial_impulse, 0))
		
		# Espera el delay antes de permitir el siguiente spawn
		await get_tree().create_timer(spawn_delay).timeout
		is_spawning = false
