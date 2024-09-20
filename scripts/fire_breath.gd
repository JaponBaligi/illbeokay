#extends Area2D
#
#var level = 1
#var hp = 1
#var speed = 100
#var damage = 5
#var knockback_amount = 100
#var attack_size = 1.0
#
#var attack_duration = 4.0  # Duration before the attack disappears
#var angles = []  # Angles at which firebreath instances will appear
#
#@onready var player = get_tree().get_first_node_in_group("player")
#@onready var sprite = $AnimatedSprite2D
#
#signal remove_from_array(object)
#
#func _ready():
#	# Ensure player reference is valid
#	if not player:
#		queue_free()
#		return
#
#	# Set angles based on level
#	match level:
#		1:
#			angles = [-270]  # Single firebreath at -270 degrees
#			hp = 1
#			damage = 5
#			attack_size = 1.0 * (1 + player.spell_size)
#		2:
#			angles = [-270, 0]  # Firebreath at -270 and 0 degrees
#			hp = 1
#			damage = 5
#			attack_size = 1.0 * (1 + player.spell_size)
#		3:
#			angles = [-270, 0, 90]  # Firebreath at -270, 0, and 90 degrees
#			hp = 2
#			damage = 8
#			attack_size = 1.0 * (1 + player.spell_size)
#		4:
#			angles = [-270, 0, 90, 180]  # Firebreath at -270, 0, 90, and 180 degrees
#			hp = 2
#			damage = 8
#			attack_size = 1.0 * (1 + player.spell_size)
#
#	# Create multiple firebreath instances based on angles
#	for angle in angles:
#		spawn_firebreath(angle)
#
#	# Set a timer to remove the firebreath after the attack duration
#	var timer = Timer.new()
#	timer.wait_time = attack_duration
#	timer.one_shot = true
#	timer.autostart = true
#	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
#	add_child(timer)
#	timer.start()
#
#func spawn_firebreath(angle_degrees: float):
#	# Convert angle from degrees to radians
#	var angle_radians = deg_to_rad(angle_degrees)
#
#	# Calculate the offset position based on the angle
#	var offset_position = Vector2(-38, 0).rotated(angle_radians)
#
#	# Instantiate a new firebreath and set its position
#	var firebreath_instance = self.duplicate()  # Duplicate the firebreath instance
#	firebreath_instance.global_position = player.global_position + offset_position
#	firebreath_instance.rotation = angle_radians  # Rotate the firebreath instance
#	add_child(firebreath_instance)
#
#	# Scale the sprite based on attack size
#	firebreath_instance.scale = Vector2(1, 1) * attack_size
#	firebreath_instance.sprite.play("default")  # Play the firebreath animation
#
#func _physics_process(delta):
#	# Ensure all firebreath instances stay at a fixed offset from the player
#	if player:
#		global_position = player.global_position  # Base firebreath instance position
#
#func _on_timer_timeout():
#	emit_signal("remove_from_array", self)
#	queue_free()
#
