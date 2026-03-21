extends TextureButton
signal rollDice()

@onready var dice = find_child("Dice")

func _ready():
	pass

func _process(_delta):
	if dice.curState == dice.state.ROLLING:
		disabled = true
	elif dice.curState == dice.state.IDLE:
		disabled = false
	pass

func _on_pressed():
	rollDice.emit()
