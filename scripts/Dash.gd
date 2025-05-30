extends State

var can_transition: bool = false

func enter():
	super.enter()
	animation_player.play("glowing")
	await dash()
	can_transition = true

func dash():
	var tween = create_tween()
	tween.tween_property(owner,"position", player.position, 0.8)
	await tween.finished

func transition():
	if can_transition:
		can_transition = true
		
		get_parent().change_state("Follow")
