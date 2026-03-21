extends CanvasLayer
signal showMenu()
signal hideMenu()

var tween

# Called when the node enters the scene tree for the first time.
func _ready():
	showMenu.connect(_show_menu)
	hideMenu.connect(_hide_menu)

func _show_menu():
	visible = true
	offset.y = 350 * randi_range(-1,1)
	offset.x = 500 * randi_range(-1,1)
	
	if tween:
		tween.kill()
	
	tween = get_tree().create_tween()
	tween.tween_property(self, "offset", Vector2(0, 0), 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
func _hide_menu():
	offset = Vector2(0,0)
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	
	var targOff_y = 350 if randi_range(0,1) == 1 else -350
	var targOff_x = 500 * randi_range(-1,1)
	tween.tween_property(self, "offset", Vector2(targOff_x, targOff_y), 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	
	await tween.finished
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_back_button_up():
	hideMenu.emit()
