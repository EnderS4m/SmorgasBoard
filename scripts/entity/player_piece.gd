extends Sprite2D

var result: int = 0

var mouseHovered: bool = false
var selected: bool = false

var baseScale: Vector2
var hoverScaleFactor: float = 1.25

var homePos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	baseScale = scale
	homePos = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# The player piece will smoothly scale up with the mouse pointer is
	# hovering over the sprite, but not if the sprite is currently
	# being dragged around
	if mouseHovered and not selected:
		scale = ((baseScale * hoverScaleFactor) / 2) + (scale / 2)
	else:
		scale = (baseScale / 2) + (scale / 2)
	
	# Dragging the sprite around
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and selected:
		position = get_global_mouse_position()
		
func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			selected = true
		else:
			selected = false

func _on_dice_dice_result(value):
	result = value

func _on_area_2d_mouse_entered():
	mouseHovered = true

func _on_area_2d_mouse_exited():
	mouseHovered = false
