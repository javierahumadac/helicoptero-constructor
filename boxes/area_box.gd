extends Area2D

var box_inside : RigidBody2D
enum ShapeType {
	SQUARE,
	CIRCLE,
	TRIANGLE,
	RECTANGLE
}
enum ColorType {
	WHITE,
	RED,
	GREEN,
	BLUE,
	YELLOW,
}
@export var type: ShapeType = ShapeType.SQUARE
@export var current_color: ColorType = ColorType.WHITE
@export var can_accept_any_color : bool = false
@export var make_bodies_freeze : bool = true

func get_type() -> String:
	match type:
		ShapeType.SQUARE:
			return "Square"
		ShapeType.CIRCLE:
			return "Circle"
		ShapeType.TRIANGLE:
			return "Triangle"
		ShapeType.RECTANGLE:
			return "Rectangle"
		_:
			return "Unknown"

func get_color() -> String:
	match current_color:
		ColorType.WHITE:
			return "White"
		ColorType.RED:
			return "Red"
		ColorType.BLUE:
			return "Blue"
		ColorType.GREEN:
			return "Green"
		ColorType.YELLOW:
			return "Yellow"
		_:
			return "Unknown"

func set_color(new_color: ColorType) -> void:
	match new_color:
		ColorType.WHITE:
			current_color = new_color
			$Sprite2D.modulate = Color.WHITE
		ColorType.RED:
			current_color = new_color
			$Sprite2D.modulate = Color.RED
		ColorType.GREEN:
			current_color = new_color
			$Sprite2D.modulate = Color.GREEN
		ColorType.BLUE:
			current_color = new_color
			$Sprite2D.modulate = Color.BLUE
		ColorType.YELLOW:
			current_color = new_color
			$Sprite2D.modulate = Color.YELLOW
		_:
			print("unknown")

func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.autostart = true
	timer.timeout.connect(_check_completed)
	timer.start()
	
	set_color(current_color)

var is_area_completed = false
var original_modulate = Color.WHITE

func _check_completed():
	var area_completed = false
	if(has_overlapping_areas()):
		for area in get_overlapping_areas():
			var body = area.get_parent()
			if(body.is_in_group("Box")):
				if(body.get_type() == get_type() and body.get_color() == get_color() or can_accept_any_color):
					var entity_linear_velocity = snapped(body.linear_velocity, Vector2(0.1 , 0.1))
					if (entity_linear_velocity == Vector2(0.0,0.0)):
						area_completed = true
						if(make_bodies_freeze):
							body.set_deferred("freeze", true)
						if original_modulate == Color.WHITE:
							original_modulate = body.get_node("Sprite2D").modulate
						body.modulate = Color(0.8, 0.8, 0.8)
						break
	
	if not area_completed and is_area_completed:
		for area in get_overlapping_areas():
			var body = area.get_parent()
			if(body.is_in_group("Box")):
				body.modulate = original_modulate
	
	is_area_completed = area_completed

func _process(delta):
	pass
