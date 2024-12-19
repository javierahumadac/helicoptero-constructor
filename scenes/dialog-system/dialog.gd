extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

signal mensaje_finalizado

func _on_new_mensaje_dialog(mensaje, seg):
	$Mensaje.visible = true
	$Mensaje.text = mensaje
	await get_tree().create_timer(seg).timeout
	$Mensaje.visible = false
	mensaje_finalizado.emit()

func _on_figuresscene_send_message(mensaje):
	$Mensaje.visible = true
	$Mensaje.text = mensaje
	await get_tree().create_timer(6).timeout
	$Mensaje.visible = false
