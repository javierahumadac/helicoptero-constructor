extends Node2D

@onready var dialogo = $Camera2D/dialog

var historia_texto = [
	[
		"Bienvenido!",
		"SOY YO EL HERMANO DE BLOMBO!"
	]
]
var historia_segunds = [
	[
		4,
		8
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
		if indice_escena == 0:
			$"Pipe-spawner".enable_spawning()
		indice_escena += 1
