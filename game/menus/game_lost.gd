extends ColorRect


func _ready():
	await get_tree().process_frame
	GlobalGameState.game_lost.connect(_on_game_lost)


func _on_game_lost():
	get_tree().paused = true
	show()


func _input(event):
	if event.is_action_pressed("restart"):
		GlobalGameState.game = null
		GlobalGameState.player = null
		GlobalGameState.HUD = null
		GlobalGameState.infuse_controller = null
		GlobalGameState.game_decided = false
		get_tree().reload_current_scene()
