extends Area2D

@export var exp = 1

var exp_orb1 = preload("res://Textures/Items/Orbs/xp-orb1.png")
var exp_orb2 = preload("res://Textures/Items/Orbs/xp-orb2.png")
var exp_orb3 = preload("res://Textures/Items/Orbs/xp-orb3.png")

var target = null
var speed = -1

@onready var sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@onready var sound = $snd_collect

func _ready():
	if exp < 5:
		sprite.play("orb1")
	elif exp < 25:
		sprite.play("orb2")
	else:
		sprite.play("orb3")

func _physics_process(delta):
	if target != null :
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 2*delta

func collect():
	collision.call_deferred("set","disabled", true)
	sprite.visible = false
	return exp


func _on_snd_collect_finished():
	queue_free()
