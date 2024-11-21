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
# Getter para el tipo
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

# Getter para obtener el color actual
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

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0  # 1 segundo
	timer.one_shot = false    # Hacer que se repita (no sea de un solo disparo)
	timer.autostart = true    # Comenzar automáticamente
	timer.timeout.connect(_check_completed)
	timer.start()
	
	set_color(current_color)
	#area_entered.connect(_on_area_entered)
	#area_exited.connect(_on_area_exited)

var is_area_completed = false

func _check_completed():
	var area_completed = false
	if(has_overlapping_areas()):
		for area in get_overlapping_areas():
			var body = area.get_parent()
			if(body.is_in_group("Box")):
				if(
					body.get_type() == get_type() and body.get_color() == get_color()
					or can_accept_any_color):
					var entity_linear_velocity = snapped(body.linear_velocity, Vector2(0.1 , 0.1))
					if (entity_linear_velocity == Vector2(0.0,0.0)):
						area_completed = true
						if(make_bodies_freeze):
							body.set_deferred("freeze", true)
						break
	is_area_completed = area_completed
#var body_in_area = null
#func _on_area_entered(area):
	#var body = area.get_parent()
#
	#if(body.is_in_group("Box")):
		##print("COLOR:", body.get_color(), get_color())
		##print("TYPE:", body.get_type(), get_type())
		#if(body.get_type() == get_type() and body.get_color() == get_color()):
			#body_in_area = body
			##body.set_deferred("freeze", true)
#
#func _on_area_exited(area):
	#var body = area.get_parent()
#
	#if(is_area_completed):
		#print("Cuerpo salio al área: ", body)
		#body_in_area = null
		#is_area_completed = false
#
#var is_area_completed = false
#signal area_completed
#signal area_uncompleted
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


