extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $Sprite2D
@onready var hitBox = $HitBox
@onready var hurtBox = $HurtBox  # Hurtbox'a erişimi ekledik
@onready var body = $Body
@export var enemy_damage = 1
@onready var playerdetection = $PlayerDetection

var knockback = Vector2.ZERO
var direction : Vector2
var DEF = 0

var health = 6000:
	set(value):
		health = value
		if value <= 0:
			find_child("FiniteStateMachine").change_state("Death")
			_disable_interaction()
		elif value <= health / 2 and DEF == 0:
			DEF = 5
			find_child("FiniteStateMachine").change_state("ArmorBuff")

func _ready():
	set_physics_process(false)
	hitBox.damage = enemy_damage

func _process(delta):
	direction = player.position - position
	
	if direction.x > 0.1:
		sprite.flip_h = false
	elif direction.x < -0.1:
		sprite.flip_h = true

func _physics_process(delta):
	velocity = direction.normalized() * 20
	move_and_collide(velocity * delta)

func _on_hurt_box_hurt(damage, angle, knockback_amount):
	health -= damage - DEF
	knockback = angle * knockback_amount

func _disable_interaction():
	# Hitbox ve Hurtbox'ı devre dışı bırak
	if hitBox:
		hitBox.set_deferred("monitoring",false)
		hitBox.set_deferred("monitorable",false)
	if hurtBox:
		hurtBox.set_deferred("monitoring",false)
		hurtBox.set_deferred("monitorable",false)
	set_physics_process(false)  # Fizik işlemlerini durdur
	if body:
		body.set_deferred("disabled",true)
	if playerdetection:
		playerdetection.set_deferred("monitoring",false)
		playerdetection.set_deferred("monitorable",false)
