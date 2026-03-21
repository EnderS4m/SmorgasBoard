extends TextureButton
signal changeMode()

var camMode: int
@onready var camera = $"../../../CameraSystem"

func _ready():
	camera.camModeSignal.connect(_get_cam_mode)

func _process(_delta):
	pass

func _on_pressed():
	pass

func _get_cam_mode(mode: int):
	camMode = mode

func _on_button_up():
	changeMode.emit()
