extends AIState



func on_enter(_previous_state: AIState = null):
	var human: Human = unit as Human
	assert(human.targetted_resource_structure != null, "No target for going to resource")
	
	var as_tree = human.targetted_resource_structure as TreeStructure
	ai_tree.target_position = as_tree.harvest_location.global_position


func update():
	var human: Human = unit as Human
	var target: Structure = human.targetted_resource_structure
	if target == null or target.is_queued_for_deletion():
		ai_tree.transition_to("idle")
		return
	
	if ai_tree.is_target_reached():
		ai_tree.transition_to("harvesting_wood")
