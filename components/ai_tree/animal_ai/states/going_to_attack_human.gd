extends AIState


func on_enter(_previous_state: AIState = null):
	ai_tree.target_position = unit.target_access_point.global_position


func update():
	if is_instance_valid(unit.target) == false:
		ai_tree.transition_to("idle")
		return
	
	if ai_tree.is_target_reached():
		ai_tree.transition_to("attacking_human")
	else:
		ai_tree.target_position = unit.target_access_point.global_position


func passive_update() -> void:
	if priority_level <= ai_tree.current_state.priority_level:
		return
	
	var closest_human_in_range: Human = null
	var closest_distance_squared: float = INF
	
	for body in unit.unit_sight_range.get_overlapping_bodies():
		if !(body is Human):
			continue
		
		if body.health <= 0 or body.is_queued_for_deletion():
			continue
		
		if unit.can_target_unit(body) == false:
			continue
		
		var distance_squared: float = unit.global_position.distance_squared_to(body.global_position)
		if distance_squared < closest_distance_squared:
			closest_distance_squared = distance_squared
			closest_human_in_range = body
	
	if closest_human_in_range != null:
		unit.target_unit(closest_human_in_range)
		ai_tree.transition_to(state_name)
