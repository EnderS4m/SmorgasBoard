extends Camera2D
signal camModeSignal(mode: int)

@onready var camButton = $"../InGameUI/UtilityButtons/CameraButton"

enum camModes {
	PLAYERCAM,
	FREEROAM
}

var activeCamMode: int
var playerHome: Vector2

const BASEZOOM: float = 1
const FREEZOOM: float = 0.75
const ZOOMWEIGHT: float = 0.25

# Called when the node enters the scene tree for the first time.
func _ready():
	camButton.changeMode.connect(_on_change_mode)
	activeCamMode = camModes.PLAYERCAM
	camModeSignal.emit(activeCamMode)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if activeCamMode == camModes.FREEROAM:
		zoom = Vector2(lerpf(zoom.x, FREEZOOM, ZOOMWEIGHT), lerpf(zoom.y, FREEZOOM, ZOOMWEIGHT))
		if Input.is_action_just_pressed("Left Click"):
			position = get_global_mouse_position()

	elif activeCamMode == camModes.PLAYERCAM:
		position = playerHome
		zoom = Vector2(lerpf(zoom.x, BASEZOOM, ZOOMWEIGHT), lerpf(zoom.y, BASEZOOM, ZOOMWEIGHT))

func _on_player_home_update(home):
	playerHome = home

func _on_change_mode():
	activeCamMode += 1
	activeCamMode = activeCamMode % 2
	camModeSignal.emit(activeCamMode)
