extends Sprite2D

var id: int
var maxID: int

var spaceTypes: Dictionary = {
	"start":"start",
	"goal":"goal",
	"points":"points",
	"mult":"mult",
	"cash":"cash",
}

var spaceTypesAssets: Dictionary = {
	"start":"res://assets/sprites/board/space_start.png",
	"goal":"res://assets/sprites/board/space_goal.png",
	"points":"res://assets/sprites/board/space_points.png",
	"mult":"res://assets/sprites/board/space_mult.png",
	"cash":"res://assets/sprites/board/space_cash.png",
}

var assetFallback: String = "res://assets/sprites/board/placeholder_spacePoints.png"

var spaceType: String
var spaceTypeAssetPath: String

@onready var dice: AnimatedSprite2D = $"../InGameUI/DiceButtons/Button_RollDice/Dice"
@onready var player: Sprite2D = $"../PlayerPiece"
@onready var area = $Area2D

var diceResult: int = -100
var playerSpaceID: int = -50

func _ready():
	area.monitorable = true
	player.player_finish_intro.connect(_intro_finish)
	spaceTypeAssetPath = spaceTypesAssets.get(spaceType, assetFallback)
	
	texture = load(spaceTypeAssetPath)
	dice.dice_result.connect(_dice_result)
	player.player_space_id.connect(_player_space)
	
	var tween = get_tree().create_tween()
	scale = Vector2(0,0)
	tween.tween_property(self, "scale", Vector2(1,1), 0.5).set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	

func _process(_delta):
	if dice.curState == dice.state.RESULT:
		if id == playerSpaceID + diceResult or ((maxID <= playerSpaceID + diceResult) and id == maxID):
			area.monitorable = true
		else:
			area.monitorable = false

func _dice_result(result: int):
	diceResult = result

func _player_space(val: int):
	playerSpaceID = val

func _intro_finish():
	area.monitorable = false
