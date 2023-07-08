extends AIState


func on_enter(_previous_state: AIState = null):
	ai_tree.target_position = GlobalGameState.game.island.hq.drop_off_location.global_position


func update():
	var human: Human = unit as Human
	if ai_tree.is_target_reached():
		GlobalGameState.game.island.hq.held_wood += human.amount_wood_held
		human.amount_wood_held = 0
		ai_tree.transition_to("idle")
