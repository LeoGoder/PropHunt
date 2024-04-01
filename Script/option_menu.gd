extends Control

@onready var optionButton = $ColorRect/VBoxContainer/HBoxContainer3/WindowButton2 as OptionButton
@onready var ResolutionOptionButton = %ResolutionButton as OptionButton

const RESOLUTION_DICTIONNARY : Dictionary = {
	"1920 x 1080" : Vector2i(1920, 1080),
	"1280 x 780" : Vector2i(1280, 720),
	"3440 x 1440" : Vector2i(3440, 1440)
}


const WINDOW_MODE_ARRAY : Array[String] = [
	"Full-Screen",
	"Window Mode",
	"Bordeless Window",
	"Bordeless Full-Screen"
]

func _ready():
	add_window_mode_items()
	optionButton.item_selected.connect(on_window_mode_selected)
	add_resolution_items()
	ResolutionOptionButton.item_selected.connect(on_resolution_selected)
	
func add_window_mode_items():
	for window_mode in WINDOW_MODE_ARRAY:
		optionButton.add_item(window_mode)

func on_window_mode_selected(index : int):
	match index:
		0: # Fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1: #Window mode 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2: #Bordeless Window
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		3: #Bordeless Fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)


func add_resolution_items():
	for resolution_size_text in RESOLUTION_DICTIONNARY:
		ResolutionOptionButton.add_item(resolution_size_text)

func on_resolution_selected(index : int):
			DisplayServer.window_set_size(RESOLUTION_DICTIONNARY.values()[index])
			get_tree().root.content_scale_size = RESOLUTION_DICTIONNARY.values()[index]

