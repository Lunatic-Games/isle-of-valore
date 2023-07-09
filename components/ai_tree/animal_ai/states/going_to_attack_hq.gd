extends AIState


func on_enter(_previous_state: AIState = null) -> void:
	ai_tree.target_position = unit.target_access_point.global_position


func update() -> void:
	if ai_tree.is_target_reached():
		ai_tree.transition_to("attacking_hq")


func on_exit(_next_state: AIState = null) -> void:
	pass
