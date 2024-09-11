extends Button

signal click_end()

func _on_pressed():
	$snd_click.play()
func _on_snd_click_finished():
	emit_signal("click_end")
