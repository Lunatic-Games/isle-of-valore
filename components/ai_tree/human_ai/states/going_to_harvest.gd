extends AIState


func on_enter(_previous_state: AIState = null):
	var human: Human = unit as Human
	
	ai_tree.target_position = unit.target_access_point.global_position
	human.animation_player.play("walk")


func update():
	var human: Human = unit as Human
	var target: Structure = human.target
	if target == null or target.is_queued_for_deletion():
		ai_tree.transition_to("idle")
		return
	
	var as_tree: TreeStructure = target as TreeStructure
	if as_tree and !as_tree.can_be_harvested():
		ai_tree.transition_to("idle")
		return
	
	if ai_tree.is_target_reached():
		ai_tree.transition_to("harvesting_wood")
