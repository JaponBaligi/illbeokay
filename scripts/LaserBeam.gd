extends State

@onready var pivot = $"../../Pivot"

var can_transition: bool = false

signal remove_from_array(object)

var enemy_damage = 1

@onready var hitbox = $"../../Pivot/Sprite2D/HitBox"

@onready var sound = $snd_laser

func enter():
	super.enter()
	await play_animation("laser_cast")
	sound.play()
	await play_animation("laser")
	can_transition = true

func play_animation(anim_name):
	animation_player.play(anim_name)
	await animation_player.animation_finished

	pivot.rotation = (owner.direction - pivot.position).angle()

func set_target():
	pivot.rotation = (owner.direction - pivot.position).angle()

func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Dash")

func _on_hit_box_area_entered(area):
	hitbox.damage = enemy_damage
