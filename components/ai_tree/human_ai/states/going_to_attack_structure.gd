extends AIState


func on_enter(_previous_state: AIState = null):
	var human: Human = unit as Human
	var target_structure: Structure = human.target
	assert(target_structure != null, "No target structure")
	
	ai_tree.target_position = target_structure.get_closest_interact_position(human.global_position)


func update():
	var human: Human = unit as Human
	if human.target == null or human.target.is_queued_for_deletion():
		ai_tree.transition_to("idle")
		return
	
	if ai_tree.is_target_reached():
		ai_tree.transition_to("attacking_structure")


func passive_update() -> void:
	if priority_level <= ai_tree.current_state.priority_level:
		return
	
	var human: Human = unit as Human
	var closest_den_in_range: Den = null
	var closest_distance_squared: float = INF
	
	for body in human.structure_sight_range.get_overlapping_bodies():
		if !(body is Den):
			continue
		
		if body.health <= 0 or body.is_queued_for_deletion():
			continue
		
		var distance_squared: float = human.global_position.distance_squared_to(body.global_position)
		if distance_squared < closest_distance_squared:
			closest_distance_squared = distance_squared
			closest_den_in_range = body
	
	if closest_den_in_range != null:
		human.target = closest_den_in_range
		ai_tree.transition_to(state_name)
