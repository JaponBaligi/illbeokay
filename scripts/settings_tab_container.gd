extends Control

signal change_aim_mode
signal change_music_mode

@onready var automatic_checkbox = $TabContainer/Controls/MarginContainer/VBoxContainer/lbl_aimmode/automatic_checkbox
@onready var manual_checkbox = $TabContainer/Controls/MarginContainer/VBoxContainer/lbl_aimmode/manual_checkbox
@onready var chill_checkbox = $TabContainer/Sound/checkbox_chill
@onready var hyped_checkbox = $TabContainer/Sound/checkbox_hyped

func _ready():
	automatic_checkbox.connect("toggled", Callable(self, "_on_automatic_toggled"))
	manual_checkbox.connect("toggled", Callable(self, "_on_manual_toggled"))
	manual_checkbox.set_pressed_no_signal(true)
	chill_checkbox.toggled.connect(_on_chill_checkbox_toggled)
	hyped_checkbox.toggled.connect(_on_hyped_checkbox_toggled)
	chill_checkbox.set_pressed_no_signal(true)

func _on_automatic_toggled(button_pressed):
	if button_pressed:
		manual_checkbox.set_pressed(false)
		emit_signal("change_aim_mode", "automatic")

func _on_manual_toggled(button_pressed):
	if button_pressed:
		automatic_checkbox.set_pressed(false)
		emit_signal("change_aim_mode", "manual")

func _on_chill_checkbox_toggled(button_pressed: bool):
	if button_pressed:
		hyped_checkbox.set_pressed_no_signal(false)
		get_node("/root/MusicModeChanger").change_music_mode("chill")

func _on_hyped_checkbox_toggled(button_pressed: bool):
	if button_pressed:
		chill_checkbox.set_pressed_no_signal(false)
		get_node("/root/MusicModeChanger").change_music_mode("hyped")
