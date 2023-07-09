extends AIState


func on_enter(_previous_state: AIState = null):
	var hq: HQStructure = GlobalGameState.game.island.hq
	var human: Human = unit as Human
	human.animation_player.play("walk")
	human.target_structure(hq)
	ai_tree.target_position = unit.target_access_point.global_position


func update():
	var human: Human = unit as Human
	if ai_tree.is_target_reached():
		GlobalGameState.game.island.hq.store_wood(human.amount_wood_held)
		GlobalGameState.game.island.hq.attempt_upgrade()
		human.amount_wood_held = 0
		ai_tree.transition_to("idle")
