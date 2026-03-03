extends Sprite2D

var result: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_dice_dice_result(value):
	result = value
	print(value)
