extends RigidBody2D


enum ColorType {
	WHITE,
	RED,
	GREEN,
	BLUE,
	YELLOW,
}


@export var current_color: ColorType = ColorType.WHITE

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
			$Punta.modulate = Color.WHITE
		"red":
			current_color = ColorType.RED
			$Punta.modulate = Color.RED
		"green":
			current_color = ColorType.GREEN
			$Punta.modulate = Color.GREEN
		"blue":
			current_color = ColorType.BLUE
			$Punta.modulate = Color.BLUE
		"yellow":
			current_color = ColorType.YELLOW
			$Punta.modulate = Color.YELLOW
		_:
			print("unknown")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_paint_zone_body_entered(body):
	if(body.is_in_group("Box")):
		body.set_color(get_color())
		#print("COLOR:", body.get_color())
		#print("TYPE:", body.get_type())
