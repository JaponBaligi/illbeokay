extends Control

# ONREADY SECTION

@onready var exit_mainmenu = $MarginContainer/VBoxContainer/btn_exitmainmenu

# SIGNAL SECTION

signal quit_options_menu

func _ready():
	exit_mainmenu.button_down.connect(_on_exit_pressed)
	set_process(false)

func _on_exit_pressed():
	quit_options_menu.emit()
	set_process(false)
	
