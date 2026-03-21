extends OptionButton


# Called when the node enters the scene tree for the first time.
func _ready():
	selected = Config.config.get_value("settings","cur_size")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_item_selected(index):
	Config.config.set_value("settings","window_size",Config.WINDOW_SIZE[index])
	Config.curSize = index
	Config.config.set_value("settings","cur_size",Config.curSize)
	Config.config.save(Config.configPath)
