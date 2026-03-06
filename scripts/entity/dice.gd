extends AnimatedSprite2D
signal dice_result(value: int)

@onready var dice = $"."
@onready var roll_timer = $RollTimer

# Current state of the dice
# IDLE: The dice slowly goes through random number results
# ROLLING: The dice swiftly goes through random number results, slowing
# down towards the end. Leads into the RESULT state when finished
# RESULT: The dice is static and is showing off the result of the roll
enum state {
	IDLE,
	ROLLING,
	RESULT
}
# The current state of the dice, duh
var curState

# What ye be rollin'
var result: int = 0
# Lerp Weight
var progress: float = 0.0

# What the dice should scale up to when changing frames
var scaleUp: float = 1.25

func _ready():
	curState = state.IDLE
	dice.frame = randi_range(0,5)
	
func _process(delta):
	result = dice.frame - 1
	
	if curState == state.IDLE:
		idle(0.25)
		
	scaleEffect(delta)

func _on_frame_changed():
	if curState == state.IDLE or curState == state.ROLLING:
		dice.frame = randi_range(0,5)
		progress = 1
	dice_result.emit(result)

func scaleEffect(delta):
	scale = Vector2(lerpf(1,scaleUp,progress),lerpf(1,scaleUp,progress))
	if progress > 0.0:
		progress -= 0.1 * delta * 60

func idle(animSpeed: float):
	dice.play("diceRoll",animSpeed)
