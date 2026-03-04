extends Sprite2D
signal player_home(home: Vector2)

@onready var player = $"."

var result: int = 0

var mouseHovered: bool = false
var selected: bool = false

var baseScale: Vector2
var hoverScaleFactor: float = 1.25

var homePos: Vector2

func _ready():
	baseScale = scale
	homePos = position

func _process(_delta):
	# The player piece will smoothly scale up with the mouse pointer is
	# hovering over the sprite, but not if the sprite is currently
	# being dragged around
	if mouseHovered and not selected:
		scale = ((baseScale * hoverScaleFactor) / 2) + (scale / 2)
	else:
		scale = (baseScale / 2) + (scale / 2)
		
		
	handleDraggingSprite(0.1)
	
# For dragging the sprite around
#func _on_area_2d_input_event(_viewport, event, _shape_idx):
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
	#if Input.is_action_just_pressed("Left Click"):
		#selected = true
	#elif Input.is_action_just_released("Left Click"):
		#selected = false
		#homePos = get_global_mouse_position()
		#player_home.emit(homePos)
	#pass

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
	
	# FIXME: Releasing left click doesn't always update everything.
	# Likely because sometimes when the mouse is released, the Area2D isn't 
	# currently on the mouse cursor that frame
	if Input.is_action_just_pressed("Left Click") and mouseHovered:
		selected = true
	if Input.is_action_just_released("Left Click") and mouseHovered:
		selected = false
		homePos = get_global_mouse_position()
		player_home.emit(homePos)
	
	# Dragging the sprite around
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and selected:
		position = get_global_mouse_position()
	else:
		# This forces the peice to return to its home position
		position = lerp(position,homePos,speed)
