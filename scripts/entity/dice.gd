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

# For the idle() function, mostly because Godot is freaking stupid
# sometimes why can't I just call a function in the _process()
# function and have that be just one call of the function that can't
# interrupt itself raaaaaaaahhhhhhhhhhhhhh
var waiting: bool = false

func _ready():
	curState = state.IDLE
	
func _process(delta):
	if curState == state.IDLE:
		idle(1)
	if curState == state.ROLLING:
		dice.stop()
	scaleEffect(delta)

func _on_frame_changed():
	result = dice.get_frame() + 1
	dice_result.emit(result)

func scaleEffect(delta):
	scale = Vector2(lerpf(1,scaleUp,progress),lerpf(1,scaleUp,progress))
	if progress > 0.0:
		progress -= 0.1 * delta * 60

# This is meant to be entirely cosmetic but it's probably important
# to note that the result variable DOES get updated during the IDLE state
func idle(delay: float):
	if !waiting:
		progress = 1
		waiting = true
		dice.frame = randi_range(0,5)
		await get_tree().create_timer(delay).timeout
		waiting = false

# TODO: Dice starts out rolling super fast and then slows down.
# When dice rolling is fully slowed down, switch to the RESULT state, and
# stand by for further instructions
func _on_roll_dice():
	curState = state.ROLLING
	for i in range(0,10):
		print(i)
		await get_tree().create_timer(1).timeout
