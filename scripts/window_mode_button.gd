extends Control

@onready var option_button = $HBoxContainer/OptionButton

const WINDOW_MODE_ARRAY : Array[String] = [
	"Full-Screen",
	"Window Mode",
	"Borderless Window",
	"Borderless Full-Screen"
]

func _ready():
	add_window_mode_items()
	option_button.item_selected.connect(on_window_mode_selected)

func add_window_mode_items():
	for window_mode in WINDOW_MODE_ARRAY:
		option_button.add_item(window_mode)

func on_window_mode_selected(index: int):
	match index:
		0: #fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1: #window mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2: #borderless window
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		3: # borderless full-screen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
