extends ColorRect


func _ready():
	if visible:
		get_tree().paused = true


func _input(event):
	if visible and event.is_action_pressed("perform_ability"):
		hide()
		$AnimationPlayer.play("intro")


func unpause():
	get_tree().paused = false
	GlobalGameState.game_started.emit()
