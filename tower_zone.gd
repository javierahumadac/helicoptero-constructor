extends Node2D

@onready var area = $Area2D
signal nueva_mejor_altura(altura)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var current_best_pos = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for entity in area.get_overlapping_bodies():
		var entity_linear_velocity = snapped(entity.linear_velocity, Vector2(1 , 1))
		if (entity_linear_velocity == Vector2(0.0,0.0)):
			var best_pos = snapped(entity.global_position.y, 1)
			if(current_best_pos > best_pos):
				current_best_pos = best_pos
				$Progress.scale.y = - best_pos
				nueva_mejor_altura.emit(best_pos)
