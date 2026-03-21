extends Node

var config = ConfigFile.new()
var configPath = "user://config.cfg"

var WINDOW_SIZE: Array = [
	Vector2i(640,360),
	Vector2i(1280, 720),
	Vector2i(1920, 1080),
	Vector2i(2560,1440)
]

var curSize: int

var fullscreen: bool

var fastDiceRoll: bool

func _ready():
	
	if not FileAccess.file_exists(configPath):
		config.set_value("settings","window_size",WINDOW_SIZE[3])
		config.set_value("settings","cur_size",3)
		config.set_value("settings","fast_dice_roll",false)
		
		config.save(configPath)
	else:
		config.load(configPath)

func _process(_delta):
	windowSizeSetting()

func windowSizeSetting():
	get_window().set_size(config.get_value("settings","window_size"))
	get_window().move_to_center()
	#if Input.is_action_just_pressed("ui_accept"):
		#curSize += 1
		#curSize = curSize % 4
		#get_window().set_size(WINDOW_SIZE.values()[curSize])
		#get_window().move_to_center()
