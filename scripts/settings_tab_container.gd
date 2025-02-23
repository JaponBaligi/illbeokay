extends Control

signal change_aim_mode

@onready var automatic_checkbox = $TabContainer/Controls/MarginContainer/VBoxContainer/lbl_aimmode/automatic_checkbox
@onready var manual_checkbox = $TabContainer/Controls/MarginContainer/VBoxContainer/lbl_aimmode/manual_checkbox

func _ready():
	automatic_checkbox.connect("toggled", Callable(self, "_on_automatic_toggled"))
	manual_checkbox.connect("toggled", Callable(self, "_on_manual_toggled"))
	automatic_checkbox.set_pressed_no_signal(true)

func _on_automatic_toggled(button_pressed):
	if button_pressed:
		manual_checkbox.set_pressed(false)
		emit_signal("change_aim_mode", "automatic")

func _on_manual_toggled(button_pressed):
	if button_pressed:
		automatic_checkbox.set_pressed(false)
		emit_signal("change_aim_mode", "manual")

func _on_change_aim_mode(mode : String):
	GameData.aiming_mode = mode
