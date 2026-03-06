extends Node2D

@onready var player = $"../PlayerPiece"
@onready var spaceScene = preload("res://scenes/board/space.tscn")

var boardLength: int = 10
var spaceSpace: int = 54
var spaceRise: int = 27

# Called when the node enters the scene tree for the first time.
func _ready():
	position = player.position
	for i in range(boardLength):
		var space = spaceScene.instantiate()
		space.position = position
		# This line isn't really THAT important, mainly just
		# proof of concept for random space generation
		space.self_modulate = Color(randf_range(0.5,1),randf_range(0,1),randf_range(0.5,1))
		add_sibling.call_deferred(space)
		position.x += spaceSpace
		position.y += spaceRise


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
