extends Area2D

var level: int = 1
var base_damage: float = 5.0
var damage_increase_factor: float = 1.25
var skull_count: int = 1
var skull_index: int = 1
@export var rotation_speed: float = 1.5  # Kurukafanın kendi etrafında döndürme hızı
@export var orbit_radius: float = 50.0
@onready var player = get_tree().get_first_node_in_group("player")
@onready var skull_sprite = $Sprite2D  # Kurukafa sprite'ını referans al
@onready var collision_shape = $CollisionShape2D  # Kurukafa çarpışma alanı
var player_position: Vector2 = Vector2.ZERO
func _ready() -> void:
	# Kurukafaya çarpan bir düşman olup olmadığını kontrol et
	connect("body_entered", Callable(self, "_on_body_entered"))
	update_skulls()

func _process(delta):
	# Kurukafayı karakterin etrafında döndür
	var angle = rotation + rotation_speed * delta  # Dönüş açısını hesapla
	position = player.position + Vector2(orbit_radius, 0).rotated(angle + deg_to_rad(skull_index * 90))

	# Kurukafanın kendi etrafında dönmesi
	skull_sprite.rotation += rotation_speed * delta  # Kurukafanın kendi etrafında dönmesi

	rotation = angle  # Dönüş açısını güncelle

func update_skulls() -> void:
	var damage = base_damage * (damage_increase_factor ** (level - 1))
	level = player.skull_level
	match level:
		1:
			skull_count += 1
		2:
			skull_count += 1 
		3:
			skull_count += 1 
		4:
			skull_count += 1 

func set_player_position(position: Vector2) -> void:
	player_position = position

# Düşmana hasar verme fonksiyonu
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("enemy"):  # Eğer çarpışan nesne düşman grubundaysa
		var damage = base_damage * (damage_increase_factor ** (level - 1))
		var knockback_amount = 100  # Düşmana uygulamak istediğiniz itme miktarı
		var angle = (position - body.global_position).normalized()  # Düşman yönü
		var knockback = Vector2.ZERO
		body._on_hurt_box_hurt(damage, angle, knockback)  # Düşmana hasar ver
