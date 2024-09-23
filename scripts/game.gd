extends Node2D

@onready var mundo = $Vaina
@onready var boton_replay = $Vaina/Button
@onready var boton_quit = $Vaina/Button2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_P):
		mundo.show()
		#get_tree().change_scene_to_file("res://scenes/end.tscn")

func _on_button_pressed():
	get_tree().reload_current_scene()
	
func _on_button_2_pressed():
	get_tree().quit()
