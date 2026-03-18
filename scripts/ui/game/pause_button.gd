extends TextureButton

var pauseMenu = CanvasLayer
var hidingMenu: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pauseMenu = find_child("PauseMenu")
	pauseMenu.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		emit_signal("pressed")

func _on_pressed():
	if not pauseMenu.visible:
		hidingMenu = false
		pauseMenu.showMenu.emit()
	elif not hidingMenu:
		hidingMenu = true
		pauseMenu.hideMenu.emit()
