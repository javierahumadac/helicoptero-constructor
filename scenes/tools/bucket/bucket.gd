extends Area2D

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

func set_color(color : String) -> void:
	var new_color = color.to_lower()
	match new_color:
		"white":
			current_color = ColorType.WHITE
			$Paint.modulate = Color.WHITE
		"red":
			current_color = ColorType.RED
			$Paint.modulate = Color.RED
		"green":
			current_color = ColorType.GREEN
			$Paint.modulate = Color.GREEN
		"blue":
			current_color = ColorType.BLUE
			$Paint.modulate = Color.BLUE
		"yellow":
			current_color = ColorType.YELLOW
			$Paint.modulate = Color.YELLOW
		_:
			print("unknown")

# Called when the node enters the scene tree for the first time.
func _ready():
	match current_color:
		ColorType.WHITE:
			$Paint.modulate = Color.WHITE
		ColorType.RED:
			$Paint.modulate = Color.RED
		ColorType.GREEN:
			$Paint.modulate = Color.GREEN
		ColorType.BLUE:
			$Paint.modulate = Color.BLUE
		ColorType.YELLOW:
			$Paint.modulate = Color.YELLOW
		_:
			print("unknown")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area):
	var body = area.get_parent()
	body.set_color(get_color())
