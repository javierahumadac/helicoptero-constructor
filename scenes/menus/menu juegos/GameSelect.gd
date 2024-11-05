extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://scenes/modos/figuras/game.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/modos/infinite_building/mundo.tscn")



func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://scenes/test/test_change_color.tscn")


func _on_button_4_pressed():
	get_tree().change_scene_to_file("res://scenes/test/test_create_figures.tscn")
