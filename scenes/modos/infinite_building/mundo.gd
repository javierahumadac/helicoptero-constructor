extends Node2D

@onready var spawner = $Spawner
@onready var score = $UI/Score
@onready var wr_label = $UI/Score2
@onready var colorrect = $ColorRect
@onready var vaina = $Vaina
var box1_scene = preload("res://boxes/box1.tscn")
var box2_scene = preload("res://boxes/box2.tscn")
var box3_scene = preload("res://boxes/box3.tscn")
var box4_scene = preload("res://boxes/box4.tscn")
var box_list = [box1_scene, box1_scene, box1_scene, box1_scene, box2_scene, box3_scene, box4_scene]

#@export var box_scene = Resource
#var box3_scene = preload("res://boxes/box1.tscn")
#var box4_scene = preload("res://boxes/box1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_P):
		vaina.show()

var world_record = 25.0
func _on_tower_zone_nueva_mejor_altura(altura):
	score.text = str(-altura / 10) + " m"
	if(altura < 100):
		var box = box_list.pick_random().instantiate()
		box.global_position = spawner.global_position
		box.rotate(randf_range(0.0, 6.2))
		spawner.add_child(box)
	if((-altura/10) >= world_record):
		wr_label.text = str(-altura / 10) + " m"
		colorrect.color = Color.LIGHT_CORAL

func _on_button_pressed():
	get_tree().reload_current_scene()
	
func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main menu/main_menu.tscn")
