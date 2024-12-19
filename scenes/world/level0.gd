extends Node2D

@onready var dialogo = $Camera2D/dialog

var historia_texto = [
	[
		"¡Bienvenidos!",
		"El resto de los elfos se fue a huelga así que ustedes son todo lo que queda…",
		"Bueno, eso no importa, sé que son capaces de hacer el trabajo de los otros 250 elfos que se fueron, ¿No es así?",
		"No se preocupen, tendrán mi ayuda en el proceso, así que manos a la obra."
	],
	[
		"Primero que nada, mirense, ¡Están manejando un trineo de última generación!",
		"Con su imán, podrán ocupar los materiales y así construir los regalos.",
		"Intenten colocarse sobre una pieza y presionen A!",
	],
	[
		"Los juguetes necesitan color… ¡Si todo es blanco sería muy aburrido!",
		"Usen el imán para tomar la brocha, elijan el color que necesiten y pinten pieza por pieza hasta generar la figura final"
	],
	[
		"Algunas figuras se harán particularmente complicadas de hacer con materiales pequeños, para eso les tenemos…",
		"¡El junta piezas!",
		"Utilicen este novedoso artefacto para combinar piezas y generar figuras que te ayuden a terminar los regalos rápidamente.",
		"También pueden no ocupar esta hermosa (y cara) herramienta, pero les recuerdo que queda poco para terminar toooodos los regalos, ¡estamos contra el tiempo!"
	],
	[
		"A ver, veamos el siguiente regalo en la lista es…Espera, acaso… será que… no puede ser… lo..¿lo lograron?",
		"¡LO LOGRARON!",
		"¡NADIE LO ESPERABA (DE VERDAD QUE NO), PERO SALVARON LA NAVIDAD!",
		"Gracias a su gran habilidad (y ayuda de la última tecnología en construcción de regalos), pudieron llegar a tiempo",
		"¡Esto es increíble! (El próximo año los reemplazaremos por un IA)"
	]
]
var historia_segunds = [
	[
		5,
		5,
		7,
		7
	],[
		5,
		6,
		7
	],[
		5,
		9
	],[
		9,
		5,
		9,
		10
	],[
		9,
		9,
		9,
		9,
		9
	]
]
var indice_escena = 0
var indice_dialogo = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(2).timeout
	dialogo._on_new_mensaje_dialog(historia_texto[indice_escena][indice_dialogo], historia_segunds[indice_escena][indice_dialogo])
	indice_dialogo += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()


func _on_dialog_mensaje_finalizado():
	if(indice_dialogo < len(historia_texto[indice_escena])):
		dialogo._on_new_mensaje_dialog(historia_texto[indice_escena][indice_dialogo], historia_segunds[indice_escena][indice_dialogo])
		indice_dialogo += 1
	else:
		indice_dialogo = 0
		indice_escena += 1
		if indice_escena == 1:
			$"Pipe-spawner".enable_spawning()
			var timer = Timer.new()
			add_child(timer)
			timer.wait_time = 10.0
			timer.one_shot = true
			timer.timeout.connect(func():
				dialogo._on_new_mensaje_dialog(historia_texto[indice_escena][indice_dialogo], historia_segunds[indice_escena][indice_dialogo])
				timer.queue_free()  # Limpiamos el timer después de usarlo
			)
			timer.start()

func preparar_para_next_dialog():
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 10.0
	timer.one_shot = true
	timer.timeout.connect(func():
		_on_dialog_mensaje_finalizado()
		timer.queue_free()  # Limpiamos el timer después de usarlo
	)
	timer.start()
func _on_figuresscene_nivel_completado(nivel):
	print("NIVEL: " + str(nivel))
	if(nivel == 1):
		preparar_para_next_dialog()
		$Upgrade1Lock.free()
	if(nivel == 2):
		preparar_para_next_dialog()
		$Upgrade2Lock.free()
	if(nivel == 3):
		preparar_para_next_dialog()
