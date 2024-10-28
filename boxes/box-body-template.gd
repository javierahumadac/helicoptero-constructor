extends RigidBody2D

# Enumeración para los tipos de formas
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


# Variable exportada para que sea visible en el inspector
@export var type: ShapeType = ShapeType.SQUARE
@export var current_color: ColorType = ColorType.WHITE
@onready var center: Area2D = $Center

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

# Setter para establecer un nuevo color
func set_color(color : String) -> void:
	var new_color = color.to_lower()
	match new_color:
		"white":
			current_color = ColorType.WHITE
			$Sprite2D.modulate = Color.WHITE
		"red":
			current_color = ColorType.RED
			$Sprite2D.modulate = Color.RED
		"green":
			current_color = ColorType.GREEN
			$Sprite2D.modulate = Color.GREEN
		"blue":
			current_color = ColorType.BLUE
			$Sprite2D.modulate = Color.BLUE
		"yellow":
			current_color = ColorType.YELLOW
			$Sprite2D.modulate = Color.YELLOW
		_:
			print("unknown")

# Called when the node enters the scene tree for the first time.
func _ready():
	match current_color:
		ColorType.WHITE:
			$Sprite2D.modulate = Color.WHITE
		ColorType.RED:
			$Sprite2D.modulate = Color.RED
		ColorType.GREEN:
			$Sprite2D.modulate = Color.GREEN
		ColorType.BLUE:
			$Sprite2D.modulate = Color.BLUE
		ColorType.YELLOW:
			$Sprite2D.modulate = Color.YELLOW
		_:
			print("unknown")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
