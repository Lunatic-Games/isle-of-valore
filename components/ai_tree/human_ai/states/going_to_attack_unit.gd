extends AIState


func on_enter(_previous_state: AIState = null):
	var human: Human = unit as Human
	var target_unit: Unit = human.target
	assert(target_unit != null, "No target unit")
	
	ai_tree.target_position = target_unit.global_position
	human.animation_player.play("walk")


func update():
	var human: Human = unit as Human
	if human.target == null or human.target.is_queued_for_deletion():
		ai_tree.transition_to("idle")
		return
	
	if ai_tree.is_target_reached():
		ai_tree.transition_to("attacking_unit")


func passive_update() -> void:
	if priority_level <= ai_tree.current_state.priority_level:
		return
	
	var human: Human = unit as Human
	var closest_animal_in_range: Animal = null
	var closest_distance_squared: float = INF
	
	for body in human.unit_sight_range.get_overlapping_bodies():
		if !(body is Animal):
			continue
		
		if body.health <= 0 or body.is_queued_for_deletion():
			continue
		
		var distance_squared: float = human.global_position.distance_squared_to(body.global_position)
		if distance_squared < closest_distance_squared:
			closest_distance_squared = distance_squared
			closest_animal_in_range = body
	
	if closest_animal_in_range != null:
		human.target = closest_animal_in_range
		ai_tree.transition_to(state_name)
