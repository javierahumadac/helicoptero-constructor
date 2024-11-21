extends Node2D

func wakeup_static_bodies():
	for b in $WakeUpZone.get_overlapping_bodies():
		b.set_deferred("freeze", false)

# Funciones auxiliares para mejor legibilidad
func disable_stopper():
	var tween = create_tween()
	tween.tween_property($Stopper, "position", 
		$Stopper.position + Vector2(0, 10), 0.1)  # Mueve 10 pixels abajo

	# Esperar a que termine el movimiento
	await tween.finished
	$Stopper.set_collision_layer_value(1, false)
	$Stopper.set_collision_mask_value(1, false)

func enable_stopper():
	$Stopper.position = $Stopper.position - Vector2(0, 10)
	$Stopper.set_collision_layer_value(1, true)
	$Stopper.set_collision_mask_value(1, true)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(finishing):
		wakeup_static_bodies()

func _on_delete_zone_body_entered(body):
	body.free()

signal _termino_de_botar_cositas()
var finishing = false
func botar_cositas():
	# Despertamos a los bodies estaticos
	finishing = true
	await get_tree().create_timer(1.0).timeout
	disable_stopper()
	await get_tree().create_timer(3.0).timeout
	enable_stopper()
	emit_signal("_termino_de_botar_cositas")
	finishing = false
