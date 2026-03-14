extends Camera2D
signal camModeSignal(mode: int)

@onready var camButton = $"../InGameUI/UtilityButtons/CameraButton"

enum camModes {
	PLAYERCAM,
	FREEROAM
}

var activeCamMode: int

# Called when the node enters the scene tree for the first time.
func _ready():
	camButton.connect("changeMode",_on_change_mode)
	
	activeCamMode = camModes.PLAYERCAM
	camModeSignal.emit(activeCamMode)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
		pass

func _on_player_home_update(home):
	if activeCamMode == camModes.PLAYERCAM:
		position = home

func _on_change_mode():
	activeCamMode += 1
	activeCamMode = activeCamMode % 2
	camModeSignal.emit(activeCamMode)
