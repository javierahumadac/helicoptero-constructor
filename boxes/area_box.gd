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
	set_color(current_color)
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(area):
	var body = area.get_parent()
	#print("Cuerpo entró al área: ", body)

	if(body.is_in_group("Box")):
		print("COLOR:", body.get_color(), get_color())
		print("TYPE:", body.get_type(), get_type())
		if(body.get_type() == get_type() and body.get_color() == get_color()):
			body.set_deferred("freeze", true)
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
