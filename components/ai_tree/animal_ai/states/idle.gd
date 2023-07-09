extends AIState


func on_enter(_previous_state: AIState = null) -> void:
	pass


func update() -> void:
	var hq: HQStructure = GlobalGameState.game.island.hq
	unit.target_structure(hq)
	ai_tree.transition_to("going_to_attack_hq")


func on_exit(_next_state: AIState = null) -> void:
	pass
