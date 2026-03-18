extends Node

var config = ConfigFile.new()
var configPath = "user://config.cfg"

var WINDOW_SIZE: Dictionary = {
	"SMALL": Vector2i(640,360),
	"MEDIUM": Vector2i(1280, 720),
	"LARGE": Vector2i(1920, 1080),
	"CHUNKY": Vector2i(2560,1440)
}

var curSize: int = 0

var fullscreen: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	curSize = 3
	get_window().set_size(WINDOW_SIZE.values()[curSize])
	get_window().move_to_center()
	
	config.set_value("settings","window_size",WINDOW_SIZE.values()[curSize])
	config.set_value("settings","fullscreen",fullscreen)
	
	config.save(configPath)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	windowSizeSetting()

func windowSizeSetting():
	if Input.is_action_just_pressed("ui_accept"):
		curSize += 1
		curSize = curSize % 4
		get_window().set_size(WINDOW_SIZE.values()[curSize])
		get_window().move_to_center()
