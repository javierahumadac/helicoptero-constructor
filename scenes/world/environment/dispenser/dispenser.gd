extends Node2D

@export var spawner : Area2D
@export var boxes_container: Node2D
@export var square: PackedScene  # Asigna la escena en el editor

var color_list = ["RED", "GREEN", "BLUE", "YELLOW"]

func get_random_color():
	if randf() < 0.8:  # 50% de probabilidad
		return "WHITE"
	else:
		return color_list.pick_random()
# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 30.0  # 1 segundo
	timer.one_shot = false    # Hacer que se repita (no sea de un solo disparo)
	timer.autostart = true    # Comenzar automáticamente
	timer.timeout.connect(_check_completed)
	timer.start()

func _check_completed():
	if(not spawner.has_overlapping_bodies()):
		var box = square.instantiate()
		# Añadirlo a la escena
		boxes_container.add_child(box)
		box.set_color(get_random_color())
		# Posicionar el cuadrado sobre este nodo
		box.global_position = spawner.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_palanca__on_lever_activated():
	_check_completed()
