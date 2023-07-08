extends AIState


func on_enter(_previous_state: AIState = null):
	var hq: HQStructure = GlobalGameState.game.island.hq
	ai_tree.target_position = hq.get_closest_interact_position(unit.global_position)


func update():
	var human: Human = unit as Human
	if ai_tree.is_target_reached():
		GlobalGameState.game.island.hq.store_wood(human.amount_wood_held)
		human.amount_wood_held = 0
		ai_tree.transition_to("idle")
