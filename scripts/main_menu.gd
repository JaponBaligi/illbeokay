extends Control

var level = "res://scenes/world.tscn"

@onready var sound = $snd_menu
@onready var background = $BackGround
@onready var i_will = $i_will
@onready var be_okay = $be_okay
@onready var options_button = $btn_options
@onready var start_button = $btn_play
@onready var quit_button = $btn_quit
@onready var options_menu = $OptionsMenu

func _ready():
	background.play()
	i_will.play()
	be_okay.play()
	sound.play()
	handle_connecting_signals()

func _on_btn_play_pressed():
	get_tree().change_scene_to_file(level)

func _on_btn_quit_pressed():
	get_tree().quit()

func _on_btn_options_pressed():
	options_menu.set_process(true)
	options_menu.visible = true

func _on_btn_exitmainmenu_pressed():
	options_menu.visible = false

func handle_connecting_signals():
	start_button.button_down.connect(_on_btn_play_pressed)
	quit_button.button_down.connect(_on_btn_quit_pressed)
	options_button.button_down.connect(_on_btn_options_pressed)
	options_menu.quit_options_menu.connect(_on_btn_exitmainmenu_pressed)

