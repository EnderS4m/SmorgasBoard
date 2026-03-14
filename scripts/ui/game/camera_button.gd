extends TextureButton
signal changeMode()

var camMode: int
@onready var camera = $"../../../CameraSystem"

# Called when the node enters the scene tree for the first time.
func _ready():
	camera.camModeSignal.connect(_get_cam_mode)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_pressed():
	changeMode.emit()
	print(camMode)

func _get_cam_mode(mode: int):
	camMode = mode
