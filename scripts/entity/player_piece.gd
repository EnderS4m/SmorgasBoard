extends Sprite2D
signal player_home(home: Vector2)
signal player_space_id(val: int)
signal player_finish_intro()
signal reset_dice()

@onready var player = $"."
@onready var camera = $"../CameraSystem"
@onready var dice = $"../InGameUI/DiceButtons/Button_RollDice/Dice"

var result: int = 0

var mouseHovered: bool = false
var selected: bool = false
var onLegalTile: bool = false

var touchingArea2D: Area2D

var baseScale: Vector2
var hoverScaleFactor: float = 1.25

var homePos: Vector2

var camMode: int

var curSpaceID: int = -50
var curSpaceType: String = "start"
var hoverSpaceID: int = -50
var hoverSpaceType: String = "N/A"

var introAnim: bool = true

func _ready():
	baseScale = scale
	homePos = position
	player_home.emit(homePos)
	camera.camModeSignal.connect(_get_cam_mode)
	
	var tween = get_tree().create_tween()
	selected = true
	introAnim = true
	position.y = -250
	tween.tween_property(self, "position",Vector2(0,0),1.5).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	await tween.finished
	selected = false
	introAnim = false
	player_finish_intro.emit()

func _process(_delta):
	if dice.curState == dice.state.RESULT:
		# The player piece will smoothly scale up with the mouse pointer is
		# hovering over the sprite, but not if the sprite is currently
		# being dragged around
		if mouseHovered and not selected and camMode != 1:
			scale = ((baseScale * hoverScaleFactor) / 2) + (scale / 2)
		else:
			scale = (baseScale / 2) + (scale / 2)
			
	handleDraggingSprite(0.1)
	
# For dragging the sprite around
func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and dice.curState == dice.state.RESULT:
		if Input.is_action_just_pressed("Left Click") and camMode != 1:
			selected = not selected
			if onLegalTile and not selected:
				reset_dice.emit()

# The result that the dice object gives
# Probably important to know tbh...
func _on_dice_dice_result(value):
	result = value

# Take a wild guess on what these two functions do
func _on_area_2d_mouse_entered():
	mouseHovered = true

func _on_area_2d_mouse_exited():
	mouseHovered = false

# Handles all the logic for dragging the player piece around
func handleDraggingSprite(speed: Variant):
	# Dragging the sprite around
	if selected and not introAnim and dice.curState == dice.state.RESULT:
		position = get_global_mouse_position()
	else:
		# If we are on a tile we are allowed to move to,
		# Update the home position to be *that* tile
		# Duh
		if onLegalTile:
			homePos = touchingArea2D.global_position
			player_home.emit(homePos)
			curSpaceID = hoverSpaceID
			curSpaceType = hoverSpaceType
			player_space_id.emit(curSpaceID)
		# This forces the peice to return to its home position
		position = lerp(position,homePos,speed)

# TODO: Make sure to ONLY update these variables IF the
# area is a board tile!!!! Don't wanna be changing the home
# position to be on the dice, now, do we?
func _on_area_2d_area_entered(area):
	if selected:
		onLegalTile = true
		touchingArea2D = area
		hoverSpaceID = area.get_parent().id
		hoverSpaceType = area.get_parent().spaceType

func _on_area_2d_area_exited(_area):
	onLegalTile = false
	touchingArea2D = null
	hoverSpaceID = -50
	hoverSpaceType = "N/A"

func _get_cam_mode(mode: int):
	camMode = mode

#func _reset_dice():
	#homePos = touchingArea2D.global_position
	#player_home.emit(homePos)
	#curSpaceID = hoverSpaceID
	#curSpaceType = hoverSpaceType
	#player_space_id.emit(curSpaceID)
