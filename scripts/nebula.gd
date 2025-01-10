extends Area2D

var level = 1
var hp = 9999
var speed = 100
var damage = 2
var knockback_amount = 100
var attack_size = 1.0

var target = Vector2.ZERO
var angle = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $AnimatedSprite2D
signal remove_from_array(object)

func _ready():
	if target != Vector2.ZERO:
		angle = global_position.direction_to(target)
		rotation = angle.angle()
	else:
		queue_free() 

	sprite.play("default_nebula")

	match level:
		1:
			hp = 9999
			speed = 100
			damage = 5
			knockback_amount = 100
			attack_size = 1.0 * (1 + player.spell_size)
		2:
			hp = 9999
			speed = 100
			damage = 5
			knockback_amount = 100
			attack_size = 1.0 * (1 + player.spell_size)
		3:
			hp = 9999
			speed = 100
			damage = 5
			knockback_amount = 100
			attack_size = 1.0 * (1 + player.spell_size)
		4:
			hp = 9999
			speed = 100
			damage = 5
			knockback_amount = 125
			attack_size = 1.0 * (1+player.spell_size)
	
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1) * attack_size, 1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()

func _physics_process(delta):
	if delta == 0:
		return
	position += angle.normalized() * speed * delta
	if global_position.distance_to(target) < 0:
		queue_free()
		
func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		emit_signal("remove_from_array", self)
		queue_free()

func _on_timer_timeout():
	emit_signal("remove_from_array", self)
	queue_free()
