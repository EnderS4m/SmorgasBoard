extends Node2D

@onready var player = $"../PlayerPiece"
@onready var spaceScene = preload("res://scenes/board/space.tscn")

var boardLength: int = 20
var spaceSpace: int = 54
var spaceRise: int = 0

var spaces: Array[String]

func _ready():
	position = Vector2(0,0)
	for i in range(boardLength):
		var space = spaceScene.instantiate()
		space.position = position
		space.id = i
		space.maxID = boardLength - 1
		
		space.spaceType = space.spaceTypes.values()[randi_range(2,space.spaceTypes.size()-1)] if space.id != 0 and space.id != space.maxID else ("start" if space.id == 0 else "goal")
		
		add_sibling.call_deferred(space)
		spaces.append(space.spaceType)
		position.x += spaceSpace
		position.y += spaceRise
		
		await get_tree().create_timer(1.0 / boardLength).timeout
	print(spaces)

func _process(_delta):
	pass
