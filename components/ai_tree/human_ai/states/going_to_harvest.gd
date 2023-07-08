extends AIState


func on_enter(_previous_state: AIState = null):
	var human: Human = unit as Human
	var target_structure: Structure = human.targetted_structure
	assert(target_structure != null, "No target structure")
	
	ai_tree.target_position = target_structure.get_closest_interact_position(human.global_position)


func update():
	var human: Human = unit as Human
	var target: Structure = human.targetted_structure
	if target == null or target.is_queued_for_deletion():
		ai_tree.transition_to("idle")
		return
	
	if ai_tree.is_target_reached():
		ai_tree.transition_to("harvesting_wood")
