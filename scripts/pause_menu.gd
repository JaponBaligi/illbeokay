extends Control
#ESCAPE ATTACHED AS "pause_button"

func resume():
	get_tree().paused = false

func pause():
	get_tree().paused = true

func pause_menu():
	if Input.is_action_just_pressed("pause_button") and !get_tree().paused:
		self.visible = true
		pause()
	elif Input.is_action_just_pressed("pause_button") and get_tree().paused:
		self.visible = false
		resume()


func _on_resume_pressed():
	self.visible = false
	resume()


func _on_restart_pressed():
	self.visible = false
	resume()
	get_tree().reload_current_scene()


func _on_options_pressed():
	
	self.visible = false


func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	MusicModeChanger.stop_music()

func _process(delta):
	pause_menu()
