extends CheckBox


# Called when the node enters the scene tree for the first time.
func _ready():
	button_pressed = Config.config.get_value("settings","fast_dice_roll")

func _on_toggled(toggled_on):
	Config.config.set_value("settings","fast_dice_roll",toggled_on)
	Config.config.save(Config.configPath)
