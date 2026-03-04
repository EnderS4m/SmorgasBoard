extends Camera2D

enum camModes {
	PLAYERCAM,
	FREEROAM
}

var activeCamMode

# Called when the node enters the scene tree for the first time.
func _ready():
	activeCamMode = camModes.PLAYERCAM

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
		pass

func _on_player_home_update(home):
	if activeCamMode == camModes.PLAYERCAM:
		position = home
