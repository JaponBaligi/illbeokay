extends Area2D

var hp = 1
var speed = 100
var damage = 4
var velocity = Vector2.ZERO
var target = Vector2.ZERO
var angle = Vector2.ZERO  # Yön vektörü

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $AnimatedSprite2D
@onready var snd_hit = $snd_robobullet

signal remove_from_array(object)

func _ready():
	# Hedef varsa açıya dönüştür
	if target != Vector2.ZERO:
		angle = (target - global_position).normalized()
	if angle != Vector2.ZERO:
		rotation = angle.angle()  # Hedefe doğru döndür
	snd_hit.play()

func _physics_process(delta):
	position += velocity * delta
	sprite.play("default")

func player_hit(charge = 1): 
	hp -= charge
	if hp <= 0:
		emit_signal("remove_from_array", self)
		queue_free()

func _on_timer_timeout():
	emit_signal("remove_from_array", self)
	queue_free()

func set_direction(direction: Vector2) -> void:
	velocity = direction.normalized() * speed
	rotation = velocity.angle()  # Mermiyi yönlendirmek için rotasyonu ayarla
