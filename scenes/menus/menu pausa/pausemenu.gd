extends Control

func _process(delta):
	test_esc()

func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/menu juegos/GameSelect.tscn")


func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main menu/main_menu.tscn")


func resume():
	get_tree().paused = false
	
func pause():
	get_tree().paused = true
	
func test_esc():
	if Input.is_action_just_pressed("esq") and !get_tree().paused:
		pause()
	else:
		resume()
		


func _on_button_pressed():
	resume()
