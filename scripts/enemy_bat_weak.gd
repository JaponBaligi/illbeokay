extends CharacterBody2D


@export var movement_speed = 20.0
@export var hp = 40.0
@export var knockback_recovery = 3.5
@export var exp = 2
@export var enemy_damage = 1
var knockback = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var sprite = $AnimatedSprite2D
@onready var snd_hit = $bat_weak_death
@onready var hitBox = $HitBox

var exp_orb = preload("res://scenes/exp_orb.tscn")

signal remove_from_array(object)

func _ready():
	hitBox.damage = enemy_damage
	
func _physics_process(_delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery * _delta)
	
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movement_speed + knockback
	move_and_slide()

	if direction.x > 0.1:
		sprite.flip_h = true
		sprite.play("fly")
	elif direction.x < -0.1:
		sprite.flip_h = false
		sprite.play("fly")

func death():
	emit_signal("remove_from_array",self)
	sprite.play("death")
	var new_exp = exp_orb.instantiate()
	new_exp.global_position = global_position
	new_exp.exp = exp
	loot_base.call_deferred("add_child",new_exp)
	queue_free()

func _on_hurt_box_hurt(damage, angle, knockback_amount):
	hp -= damage
	knockback = angle * knockback_amount
	if hp <= 0:
		death()
	else:
		snd_hit.play()
