extends Node2D

@onready var helicoptero = $"Helicoptero"
@onready var magnet = $Magnet
@export var player_id : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	helicoptero.player_id = player_id
	magnet.player_id = player_id

func _update_player_id(player_id):
	helicoptero.player_id = player_id
	magnet.player_id = player_id

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
