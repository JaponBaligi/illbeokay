extends Area2D

var level = 1
var hp = 1
var speed = 100
var damage = 5
var knockback_amount = 100
var attack_size = 1.0

var target = Vector2.ZERO
var angle = Vector2.ZERO  # Yön vektörü

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $AnimatedSprite2D

signal remove_from_array(object)

func _ready():
	# Hedef varsa açıya dönüştür
	if target != Vector2.ZERO:
		angle = (target - global_position).normalized()
	if angle != Vector2.ZERO:
		rotation = angle.angle()  # Hedefe doğru döndür
	sprite.play("default")
	# büyüklüğünü seviyeye göre ayarla
	match level:
		1:
			hp = 1
			speed = 100
			damage = 5
			knockback_amount = 100
			attack_size = 1.0 * (1 + player.spell_size)
		2:
			hp = 1
			speed = 100
			damage = 5
			knockback_amount = 100
			attack_size = 1.0 * (1 + player.spell_size)
		3:
			hp = 1
			speed = 100
			damage = 5
			knockback_amount = 100
			attack_size = 1.0 * (1 + player.spell_size)
		4:
			hp = 1
			speed = 100
			damage = 5
			knockback_amount = 100
			attack_size = 1.0 * (1 + player.spell_size)
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1) * attack_size, 1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	
func _physics_process(delta):
	# Mermiyi fare doğrultusunda hareket ettir
	position += angle * speed * delta
# Eğer hedefe çok yaklaşırsak mermiyi yok et
	if global_position.distance_to(player.get_global_mouse_position()) < 3:
		queue_free()

func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		emit_signal("remove_from_array", self)
		queue_free()

func _on_timer_timeout():
	emit_signal("remove_from_array", self)
	queue_free()
