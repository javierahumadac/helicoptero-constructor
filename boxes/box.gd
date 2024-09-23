extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


var reset_state = false
var moveVector: Vector2

func _integrate_forces(state):
	if reset_state:
		state.transform = Transform2D(0.0, moveVector)
		print(state.transform)
		reset_state = false
		set_linear_velocity(Vector2(get_linear_velocity().x,0.0))

func move_body(targetPos: Vector2):
	moveVector = targetPos;
	reset_state = true;
	print(get_linear_velocity())
