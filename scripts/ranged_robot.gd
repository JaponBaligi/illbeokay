extends CharacterBody2D

@export var movement_speed = 20.0
@export var hp = 80.0
@export var knockback_recovery = 3.5
@export var exp = 1
@export var enemy_damage = 3

var knockback = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var sprite = $AnimatedSprite2D
@onready var snd_hit = $ranged_robot_death
@onready var hitBox = $HitBox
@onready var attack_timer = $PlayerDetectionArea/AttackCooldown
@onready var player_detection_area = $PlayerDetectionArea

var arrow_scene = preload("res://scenes/robo_ammo.tscn")
var exp_orb = preload("res://scenes/exp_orb.tscn")

signal remove_from_array(object)

@export var shooting_distance: float = 160.0  # Ateş etme mesafesi

func _ready():
	hitBox.damage = enemy_damage
	player_detection_area.body_entered.connect(self._on_player_detected)
	player_detection_area.body_exited.connect(self._on_player_lost)

func _physics_process(_delta):
	if is_instance_valid(player):
		var direction = global_position.direction_to(player.global_position)
		var distance_to_player = global_position.distance_to(player.global_position)
		
		# Saldırı mesafesi dışındaysa hareket eder
		if distance_to_player > shooting_distance:
			velocity = direction * movement_speed + knockback
			move_and_slide()
			sprite.play("walk")
		else:
			# Saldırı mesafesindeyse hareketi durdurur ve saldırır
			velocity = Vector2.ZERO
			if not attack_timer.is_stopped():
				sprite.play("attack")
		if direction.x > 0.1:
			sprite.flip_h = false
		elif direction.x < -0.1:
			sprite.flip_h = true

func death():
	emit_signal("remove_from_array",self)
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

func attack():
	if player.is_in_group("player"):
		# Ok sahnesini instantiate ediyoruz
		var arrow = arrow_scene.instantiate()
		# Oku düşmanın konumuna yerleştiriyoruz
		arrow.global_position = global_position
		# Oku oyuncuya doğru yönlendiriyoruz
		var direction = (player.global_position - global_position).normalized()
		arrow.set_direction(direction)
		# Oku sahneye ekliyoruz
		get_parent().add_child(arrow)
	# Timer'ı yeniden başlat, bu sayede sürekli saldırı yapmaz
	attack_timer.start()

func _on_attack_cooldown_timeout():
	# Sadece cooldown dolduğunda saldırı yap
	attack()

func _on_player_detected(body: Node) -> void:
	if body.is_in_group("player"):
		attack_timer.start()

func _on_player_lost(body: Node) -> void:
	if body.is_in_group("player"):
		attack_timer.stop()
