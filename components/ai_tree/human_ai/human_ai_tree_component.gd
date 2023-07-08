extends AITreeComponent


func update():
	if current_state:
		current_state.update()
