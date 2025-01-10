extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var animated_sprite = $AnimatedSprite2D
@onready var hitbox = $HitBox
@export var entity_damage = 1
var acceleration: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

func _physics_process(delta):
	acceleration = (player.position - position).normalized() 
	
	velocity += acceleration * delta
	rotation = velocity.angle()
	
	velocity += velocity.limit_length(25)
	
	position += velocity * delta

func _on_timer_timeout():
	emit_signal("remove_from_array", self)
	queue_free()

func _on_hit_box_body_entered(body):
	if body.is_in_group("player"):
		body._on_hurt_box_hurt(entity_damage, 0, Vector2.ZERO)
		queue_free()
