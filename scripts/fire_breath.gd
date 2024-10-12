extends Area2D

var distance_from_player = 50  # Distance from the player
var angle_degrees = 0  # Angle in degrees 
var damage = 10
var attack_size = 1.0
@onready var sprite = $AnimatedSprite2D
@onready var player = get_tree().get_first_node_in_group("player")

signal remove_from_array(object)

func _ready():
	update_position()
	sprite.play("phew")
	connect("body_entered", Callable(self, "_on_body_entered"))
	$snd_firebreath.play()

func _process(delta):
	if player.position != Vector2.ZERO:
		update_position()

func update_position():
	var rad = deg_to_rad(angle_degrees)
	global_position = player.position + Vector2(cos(rad), sin(rad)) * distance_from_player

