extends Area2D

signal reincarnate_started
signal reincarnate_finished

var is_reincarnating = false
var reincarnation_push_force = 1000  # force to push enemies away

@onready var death = $death_reverse
@onready var wings = $wings
@onready var rebirth_sound = $AudioStreamPlayer

func reincarnate():
	if is_reincarnating:
		return
	is_reincarnating = true
	emit_signal("reincarnate_started")
	push_enemies_back()
	death.play("death_reverse")
	wings.play("default")
	rebirth_sound.play()
	var timer = Timer.new()
	timer.wait_time = 3.0
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	timer.start()

func _on_timer_timeout():
	emit_signal("reincarnate_finished")
	is_reincarnating = false

func push_enemies_back():
	var overlapping_bodies = get_overlapping_bodies()
	for enemy in overlapping_bodies:
		if enemy.is_in_group("enemy"):
			var direction = (enemy.global_position - global_position).normalized()
			enemy.velocity = direction * reincarnation_push_force
			enemy.move_and_slide()
