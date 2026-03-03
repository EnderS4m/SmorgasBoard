extends AnimatedSprite2D

@onready var dice = $"."

var oldFrame: int = 0
var result: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	dice.frame = randi_range(0,5)
	oldFrame = dice.frame
	dice.play("diceRoll",1.5)

func _on_frame_changed():
	dice.frame = randi_range(0,5)
	result = dice.frame + 1
	print(result)
