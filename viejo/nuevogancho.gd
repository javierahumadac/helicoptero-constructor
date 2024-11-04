extends RigidBody2D

@onready var jointA = $PinJoint2D
@onready var jointB = $PinJoint2D2
@onready var catchZone = $"Catch Zone"
@onready var sprite = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var caja_agarrada = false
var tratando_de_agarrar_caja = false
var entity_caja : RigidBody2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(tratando_de_agarrar_caja):
		sprite.modulate = Color.DEEP_PINK
		if(not caja_agarrada):
			for entity in catchZone.get_overlapping_bodies():
				jointA.node_b = entity.get_path()
				jointB.node_b = entity.get_path()
				caja_agarrada = true
				entity_caja = entity
				if(entity_caja.is_in_group("Caja")):
					entity.mass = 0.1
	else:
		sprite.modulate = Color.BLACK
		if(caja_agarrada):
			jointA.node_b = self.get_path()
			jointB.node_b = self.get_path()
			caja_agarrada = false
			if(entity_caja.is_in_group("Caja")):
				entity_caja.mass = 15

