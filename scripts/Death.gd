extends State

signal remove_from_array(object)

func enter():
	super.enter()
	animation_player.play("death")
	await animation_player.animation_finished
