extends AnimatedSprite2D
signal dice_result(value: int)

@onready var dice = $"."

# What ye be rollin'
var result: int = 0
# Lerp Weight
var progress: float = 0.0

# What the dice should scale up to when changing frames
var scaleUp: float = 1.25

func _ready():
	dice.frame = randi_range(0,5)
	dice.play("diceRoll",1)
	
func _process(delta):
	scale = Vector2(lerpf(1,scaleUp,progress),lerpf(1,scaleUp,progress))
	if progress > 0.0:
		progress -= 0.1 * delta * 60

func _on_frame_changed():
	dice.frame = randi_range(0,5)
	result = dice.frame + 1
	progress = 1
	dice_result.emit(result)
