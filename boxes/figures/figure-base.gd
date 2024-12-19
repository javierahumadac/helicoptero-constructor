extends Node2D

@onready var progress : ProgressBar = $ProgressBar
@export var Figuras: Array[PackedScene]
@onready var pipe = $Pipe
var figure
# Called when the node enters the scene tree for the first time.
func _ready():
	figure = Figuras[0].instantiate()
	# Añadirlo a la escena
	add_child(figure)
	# Posicionar el cuadrado sobre este nodo
	figure.global_position = global_position
		
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0  # 1 segundo
	timer.one_shot = false    # Hacer que se repita (no sea de un solo disparo)
	timer.autostart = true    # Comenzar automáticamente
	timer.timeout.connect(_check_completed)
	timer.start()

var progress_value = 0
func _check_completed():
	var children = figure.get_children()
	var total_count = 0
	var current_count = 0
	
	for c in children:
		if c.is_in_group("Area Box"):
			if (c.is_area_completed):
				current_count += 1
			total_count += 1
	progress_value = current_count*100/total_count
	progress.value = progress_value

signal sendMessage(mensaje: String)
signal nivelCompletado(nivel: int)

var failure_messages = [
	"?????",
	"ah... bueno...",
	"vaya... no pensé que se les haria tan dificil",
	"a este paso... quizas lleguemos al año nuevo chino",
	"hmm...",
	"WOW que hermosa esta figura... que lastima que no era lo que pedimos",
	"¡Uy!, estuvieron cerca, sigan así, le están tomando el ritmo.",
	"Vaya, creo que se olvidaron que existen las brochas…",
	"Hmm, bueno, supongo que sirvió para comprobar que tienen que completar TODA la figura…",
	"Ok, con esto tengo claro que debemos reformular el sistema de capacitaciones…",
	"Control de calidad nos va a contactar si seguimos así.",
	"No se ofendan pero… quizás hace falta una visita al oculista.",
	"Está bien, lo entiendo, pueeede haber un poco de explotación laboral en su caso, pero eso no lo tienen que pagar los niños del mundo con regalos como este…",
	"Quizás me tendría que haber unido a la huelga…"
]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var nivel_completado = false
var botando_cositas = false
var nivel = 0

func _on_palanca__on_lever_activated():
	if not botando_cositas:
		botando_cositas = true
		print("Palanca activada")
		if(progress_value == 100):
			print(figure.mensaje)
			emit_signal("sendMessage", figure.mensaje)
			emit_signal("nivelCompletado", nivel)
			nivel_completado = true
		else:
			emit_signal("sendMessage", failure_messages.pick_random())
		pipe.botar_cositas()

func _on_pipe__termino_de_botar_cositas():
	if(nivel_completado):
		figure.free()
		nivel += 1
		print("Nivel a buscar: " + str(nivel))
		nivel_completado = false
		if(len(Figuras) > nivel):
			figure = Figuras[nivel].instantiate()
		else:
			figure = Figuras.pick_random().instantiate()
		# Añadirlo a la escena
		add_child(figure)
		# Posicionar el cuadrado sobre este nodo
		figure.global_position = global_position
	botando_cositas = false
